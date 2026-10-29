Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31747606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gfq90gPU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0AA10E72D;
	Thu, 29 Oct 2026 19:01:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B650A10E72D
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:01:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 66BE74388A;
 Thu, 29 Oct 2026 19:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1491F1F01816;
 Thu, 29 Oct 2026 19:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793300463;
 bh=X3R+/90f+Tf2330RKPvZV8HmufJCZILvebczyhDrUyE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Gfq90gPUGfuSHVFt5gPBIV1Aheh0dr7OtLUnHCIwwiA9afSFAWcIN876IoXJayD4C
 xW8tHCYfhdXQ4IllmmhGYxI48TK4u8TQcYTIbXpsmq5D+R5HzSfL3r1cmjl2drzdh5
 4a6Tkikh7c9aMv4inAtnGcCX0G8AjRab1Tzg5CIBfjXZMoU7vGk6cjuil+MKP70jDn
 S3dS4Niprjvb88c9i2Z1hQOF8qtNPaHYdx2YKLst0trxjUO9X0c8KH5tORw4589Csp
 kEVhoD2PKblpJgRopJl1BjhfF6qxpIQxoi6tj7iDoPTLBdf6J4tkAsE49KGhrMSSPP
 ucjLT98fWiiqA==
Date: Thu, 29 Oct 2026 14:01:00 -0500
From: Rob Herring <robh@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 09/31] accel: ethosu: Guard operations after unplug
Message-ID: <20261029190100.GB1232511-robh@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-9-4aa25e22578e@kernel.org>
 <sashiko-outbox-189512@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-189512@kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 02:26:01PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] accel: ethosu: mixing __free() and scoped_guard() with goto cleanup labels
> --
> 
> commit cbd771f7e8b7995eaa7aedcd81a7cde35a4b6ada
> Author: Rob Herring (Arm) <robh@kernel.org>
> 
> accel: ethosu: Guard operations after unplug
> 
> This commit guards ethosu device file open and private ioctl operations
> with drm_dev_enter() and drm_dev_exit(), and switches device removal from
> drm_dev_unregister() to drm_dev_unplug(). It also drops drm_dev_enter()
> from the BO wait ioctl so fence waits do not delay scheduler teardown.
> 
> > diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
> > index 6875ed17a004d..91b2c2ab0a03e 100644
> > --- a/drivers/accel/ethosu/ethosu_drv.c
> > +++ b/drivers/accel/ethosu/ethosu_drv.c
> [ ... ]
> > @@ -139,27 +132,34 @@ static int ethosu_ioctl_cmdstream_bo_create(struct drm_device *ddev, void *data,
> >  
> >  static int ethosu_open(struct drm_device *ddev, struct drm_file *file)
> >  {
> > -	int ret = 0;
> > +	struct ethosu_file_priv __free(kfree) * priv = NULL;
> > +	int cookie, ret;
> >  
> >  	if (!try_module_get(THIS_MODULE))
> >  		return -EINVAL;
> > +	if (!drm_dev_enter(ddev, &cookie)) {
> > +		module_put(THIS_MODULE);
> > +		return -ENODEV;
> > +	}
> >  
> > -	struct ethosu_file_priv __free(kfree) *priv = kzalloc_obj(*priv);
> > +	priv = kzalloc_obj(*priv);
> >  	if (!priv) {
> >  		ret = -ENOMEM;
> > -		goto err_put_mod;
> > +		goto err_dev_exit;
> >  	}
> >  	priv->edev = to_ethosu_device(ddev);
> >  
> >  	ret = ethosu_job_open(priv);
> >  	if (ret)
> > -		goto err_put_mod;
> > +		goto err_dev_exit;
> >  
> >  	ethosu_perfmon_open_file(priv);
> >  	file->driver_priv = no_free_ptr(priv);
> > +	drm_dev_exit(cookie);
> >  	return 0;
> >  
> > -err_put_mod:
> > +err_dev_exit:
> > +	drm_dev_exit(cookie);
> >  	module_put(THIS_MODULE);
> >  	return ret;
> >  }
> 
> [Severity: Medium]
> In drivers/accel/ethosu/ethosu_drv.c, ethosu_open() declares priv with
> __free(kfree) = NULL at the top of the function before try_module_get() and
> drm_dev_enter(), and then mixes __free(kfree) with goto err_dev_exit when
> kzalloc_obj() or ethosu_job_open() fails.
> 
> Because scope-based cleanup runs when the function scope exits after the
> err_dev_exit label executes, drm_dev_exit(cookie) and
> module_put(THIS_MODULE) will run before kfree(priv), reversing the reverse
> acquisition (lifo) teardown order and mixing goto error handling with
> cleanup.h helpers.
> 
> Should ethosu_open() avoid mixing __free(kfree) and goto labels so that
> priv is freed before exiting the drm device section and dropping the module
> reference?

No! There's no such requirement that everything uses scoped cleanups or 
nothing does. And delaying a free is not an issue.

Rob
