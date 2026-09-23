Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC46C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2BC10EB0B;
	Wed, 23 Sep 2026 16:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="H32qTODm";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FE6A10EB0B;
 Wed, 23 Sep 2026 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790180131;
 bh=+YZYMYfkfHKc8u0yR4874R+05o+nqj6l1VuI8859FJ0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=H32qTODmipVClIL53Wo7381WHg9WChwvA5F839Tx8g7mbGRLg2iYYP4eRB/5EBS0p
 UDUuWSIpdiATPqZ2Q4/HxjXw2nCojbRVty6vHpmYiPE1QVFoeHbgrx/4CO1vHk1lDg
 Iv1hoUp1psBdRBipsET9OxmFetz48AUbI7wUV1aokyaEd++z7SVEt9bG8vIzL5+GvU
 UJ4SNCf9QUkH49IwTh2GZzBaySU5rXXlngkbLGA34Iufwl6KLTn4BTEPio5rvQs2Gx
 foINV2n7WMyPsyIErneJzLDBTNMNBB0q5/QcIw+MALj7eMrBPdFBZtN11SpA9zFZG4
 QvDwv+DONGfrg==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 717DB17E0056;
 Wed, 23 Sep 2026 18:15:31 +0200 (CEST)
Date: Wed, 23 Sep 2026 18:15:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Kamil Konieczny <kamil.konieczny@linux.intel.com>
Cc: Deborah Brouwer <deborah.brouwer@collabora.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH i-g-t] lib/igt_profiling: configure Panthor enable state
Message-ID: <20260923181527.052f3612@fedora-32.home>
In-Reply-To: <20260923102921.hrn45pkboeo3risn@kamilkon-DESK.igk.intel.com>
References: <20260922-b4-gputop_panthor-v1-1-e908705bd062@collabora.com>
 <20260923102921.hrn45pkboeo3risn@kamilkon-DESK.igk.intel.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 23 Sep 2026 12:29:21 +0200
Kamil Konieczny <kamil.konieczny@linux.intel.com> wrote:

> Hi Deborah,
> On 2026-09-22 at 20:01:20 -0700, Deborah Brouwer wrote:
> > Currently profiling is enabled for every device by writing '1' into the
> > appropriate sysfs node. But Panthor uses a bit mask where cycle and
> > timestamp sampling are enabled by the first and second bits respectively.
> > 
> > By default assume that writing '1' will enable profiling, but then adjust
> > the value to '3' for the Panthor driver.
> > 
> > Closes: https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/work_items/209
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>  
> 
> Thank you for solving this, LGTM
> Acked-by: Kamil Konieczny <kamil.konieczny@linux.intel.com>
> 
> Can you ask some Panthor developer for review and/or Tested-by?

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> 
> Regards,
> Kamil
> 
> > ---
> >  lib/igt_profiling.c | 23 +++++++++++++++++++++--
> >  lib/igt_profiling.h |  1 +
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/igt_profiling.c b/lib/igt_profiling.c
> > index e1526ad98..5c62a3fb1 100644
> > --- a/lib/igt_profiling.c
> > +++ b/lib/igt_profiling.c
> > @@ -50,7 +50,10 @@ struct igt_profiled_device *igt_devices_profiled(void)
> >  
> >  	while ((entry = readdir(dev_dir)) != NULL) {
> >  		char path[PATH_MAX];
> > +		char driver_path[PATH_MAX];
> > +		char driver_link[PATH_MAX];
> >  		char orig_state;
> > +		ssize_t len;
> >  		int sysfs_fd;
> >  
> >  		/* All DRM device entries are symlinks to other paths within sysfs */
> > @@ -87,7 +90,23 @@ struct igt_profiled_device *igt_devices_profiled(void)
> >  		}
> >  
> >  		profiled_devices[i].syspath = strdup(path);
> > -		profiled_devices[i++].original_state = orig_state;
> > +		profiled_devices[i].original_state = orig_state;
> > +		profiled_devices[i].enable_state = '1';
> > +
> > +		snprintf(driver_path, sizeof(driver_path), "%s/%s/device/driver",
> > +			 SYSFS_DRM, entry->d_name);
> > +
> > +		len = readlink(driver_path, driver_link, sizeof(driver_link) - 1);
> > +		if (len >= 0) {
> > +			driver_link[len] = '\0';
> > +
> > +			if (strstr(driver_link, "/panthor")) {
> > +				/* Enable both cycle and timestamp sampling. */
> > +				profiled_devices[i].enable_state = '3';
> > +			}
> > +		}
> > +
> > +		i++;
> >  
> >  		close(sysfs_fd);
> >  	}
> > @@ -124,7 +143,7 @@ void igt_devices_configure_profiling(struct igt_profiled_device *devices, bool e
> >  		if (sysfs_fd < 0)
> >  			continue;
> >  
> > -		write(sysfs_fd, enable ? "1" : &devices[i].original_state, 1);
> > +		write(sysfs_fd, enable ? &devices[i].enable_state : &devices[i].original_state, 1);
> >  		close(sysfs_fd);
> >  	}
> >  }
> > diff --git a/lib/igt_profiling.h b/lib/igt_profiling.h
> > index b063d54e1..d38cc2bb6 100644
> > --- a/lib/igt_profiling.h
> > +++ b/lib/igt_profiling.h
> > @@ -12,6 +12,7 @@
> >  struct igt_profiled_device {
> >  	char *syspath;
> >  	char original_state;
> > +	char enable_state;
> >  };
> >  
> >  void igt_devices_configure_profiling(struct igt_profiled_device *devices, bool enable);
> > 
> > ---
> > base-commit: 65f84b280be2caf8ce376295d97987a808affdee
> > change-id: 20260922-b4-gputop_panthor-cbb78c0ffbf8
> > 
> > Best regards,
> > -- 
> > Deborah Brouwer <deborah.brouwer@collabora.com>
> >   

