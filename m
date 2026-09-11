Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF01BC88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7201110F72C;
	Fri, 11 Sep 2026 23:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="bjdBsd7V";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80EA810F72C
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:39:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789169940; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lRnLB55j/xILywj6XtEoFzMt1It/KcuTz0dY15oOJ6SEOktUukTKcAL1QJ4UAer5ctVEVQy5MNUgU9Y5lP2hhkOVU619b0gKnGEZmzWil7RNIfBPhw+lnyIS16SVvOrZ/esPOE5ORxFCeTAYQGuHyuty8vNZmV0+IMZHUFpk7RY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789169940;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=toKKhuIQKSaL2Znd3cgcQ5ZnRq79DpOiYAZDjzqDWX4=; 
 b=cywv7h8i1oojQYrF5OK0IAMbxFjD8DVhv9ySCTZlZaX9r5Kcd8BmGcHyNq+7zzzl/Af7PU+5j+C7Aj67r3ulu0kmt8i7FVjwWfxLE1WS/CW/Xyt0Iv++kyDz8C/oJgX03TUXFCTTXwuR1jkBaPSfUIeFrKgHh7tU+bPdL4A2kGQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789169940; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=toKKhuIQKSaL2Znd3cgcQ5ZnRq79DpOiYAZDjzqDWX4=;
 b=bjdBsd7V/xWPHgZLh+a0hVqiilFmzitVQkgZVUMsJ076s9ZJz06RxJD/9PpqWLKC
 8Qua4XpWtJ5jEZdW8kDWspyZxlhFp74JsERFn2k3srsKjCi3gOmW8mRp6RTPWRNRp2K
 glEHEy4gW2ZSTVcY9B3mMftJ4EHlvsS/KyaU2vps=
Received: by mx.zohomail.com with SMTPS id 1789169939703405.989826667481;
 Fri, 11 Sep 2026 16:38:59 -0700 (PDT)
Date: Sat, 12 Sep 2026 00:38:56 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] drm/panfrost: Rename "panthor" prefixes in debugfs
 identifiers
Message-ID: <aqSP2d1at9937MIc@sobremesa>
References: <20260901-panfrost-prefix-whoopsie-v1-1-138fb4c5a9f4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260901-panfrost-prefix-whoopsie-v1-1-138fb4c5a9f4@collabora.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.144.59
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

Hi Nicolas, thanks for the patch.

I was wondering whether it makes sense to apply it in light of changes
in a patch series I've been working on for quite some time. One of the
patches moves all debugfs plumbing away from panfrost_drv.c and into
their relevant subsystems, and as part of that change I've renamed all
erroneous panthor_* prefixes into panfrost.

However, if the right policy in this case is to have them both committed
separately, then I'll be applying this one first.

Check https://lore.kernel.org/r/20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com
patch 3/16 for further context. 

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 01.09.2026 15:39, Nicolas Frattaroli wrote:
> When gems debugfs support was copied over from panthor to panfrost, the
> function and struct names were not adjusted to carry the panfrost
> prefix instead of the panthor prefix.
> 
> Rectify this by renaming them. No functional change.
> 
> Fixes: e48ade5e23ba ("drm/panfrost: show device-wide list of DRM GEM objects over DebugFS")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 96a66d673ba6..f5f11ad5f9b3 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -794,7 +794,7 @@ static const struct file_operations panfrost_drm_driver_fops = {
>  };
>  
>  #ifdef CONFIG_DEBUG_FS
> -static int panthor_gems_show(struct seq_file *m, void *data)
> +static int panfrost_gems_show(struct seq_file *m, void *data)
>  {
>  	struct drm_info_node *node = m->private;
>  	struct panfrost_device *pfdev = to_panfrost_device(node->minor->dev);
> @@ -845,15 +845,15 @@ static int show_file_jm_ctxs(struct panfrost_file_priv *pfile,
>  	return 0;
>  }
>  
> -static struct drm_info_list panthor_debugfs_list[] = {
> +static struct drm_info_list panfrost_debugfs_list[] = {
>  	{"gems",
> -	 panthor_gems_show, 0, NULL},
> +	 panfrost_gems_show, 0, NULL},
>  };
>  
> -static int panthor_gems_debugfs_init(struct drm_minor *minor)
> +static int panfrost_gems_debugfs_init(struct drm_minor *minor)
>  {
> -	drm_debugfs_create_files(panthor_debugfs_list,
> -				 ARRAY_SIZE(panthor_debugfs_list),
> +	drm_debugfs_create_files(panfrost_debugfs_list,
> +				 ARRAY_SIZE(panfrost_debugfs_list),
>  				 minor->debugfs_root, minor);
>  
>  	return 0;
> @@ -915,7 +915,7 @@ static void panfrost_sched_debugfs_init(struct drm_minor *minor)
>  
>  static void panfrost_debugfs_init(struct drm_minor *minor)
>  {
> -	panthor_gems_debugfs_init(minor);
> +	panfrost_gems_debugfs_init(minor);
>  	panfrost_sched_debugfs_init(minor);
>  }
>  #endif
> 
> ---
> base-commit: 0116f19db5931348c937eafa1f76a9a19bf82c81
> change-id: 20260901-panfrost-prefix-whoopsie-26300bf2dce9
> 
> Best regards,
> --  
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Adrian Larumbe
