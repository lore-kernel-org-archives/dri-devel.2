Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D81C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 23:48:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0899310E167;
	Tue, 21 Jul 2026 23:48:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ckAw1HBt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DDB310E167
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:48:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C58474028A;
 Tue, 21 Jul 2026 23:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E073E1F000E9;
 Tue, 21 Jul 2026 23:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784677687;
 bh=8C4Am8J8eN/lNe79Ggj9X5yeFTmgWkFhmiw7H77ogsc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ckAw1HBt9WdOp0zTi2DdVBNsVwukXaDfyRVr2r6FVO6vee2PjLPuS/R49TQhOzl61
 4VpwcSEPdxixRK++NTR9OV6b9K/pC1ZByxnVI5O5YEwVvmxF0pbX+LhlzBond/O5kw
 TJYieUqI278uECci71jL5lbBJe/JgxQGTbcu7xvxjAwB0Wg9H4b7XH+NC9q7gymWtI
 1CsbtuvbEGX6C5ADx4lP0EwWTxcarLpxVElQmolWiKAdTf7q+93oJ3jAadoMfms5UO
 DONp2ZiVUTRzqYpzqh2SqAm9AGaI8dBu3kSujBeVvR3yF4jZLNxE0fN17AFtxeXTAa
 QtveQEjO8v7dw==
Date: Tue, 21 Jul 2026 16:48:02 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Dave Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com,
 daniels@collabora.com, jani.nikula@linux.intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch,
 ville.syrjala@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] drm: ensure blend mode supported if pixel format
 with alpha exposed
Message-ID: <20260721234802.GA439272@ax162>
References: <20260526181700.25310-1-leandro.ribeiro@collabora.com>
 <20260526181700.25310-3-leandro.ribeiro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526181700.25310-3-leandro.ribeiro@collabora.com>
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

Hi Leandro,

+ ast folks

On Tue, May 26, 2026 at 03:17:00PM -0300, Leandro Ribeiro wrote:
> Before "drm/drm_blend: allow blend mode property without PREMULTI",
> userspace would have to assume that only PREMULTI was supported by
> drivers that didn't expose the blend mode property. But now userspace
> shouldn't rely on that, as they can't count with drivers always
> supporting PREMULTI.
> 
> Warn if a driver exposes pixel formats with alpha but doesn't expose the
> blend mode property. This way userspace doesn't have to guess. Drivers
> triggering this warning must be fixed.
> 
> Signed-off-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
> ---
>  drivers/gpu/drm/drm_mode_config.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 66f7dc37b597..8cca1dea3b3d 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -674,6 +674,25 @@ static void validate_encoder_possible_crtcs(struct drm_encoder *encoder)
>  	     encoder->possible_crtcs, crtc_mask);
>  }
>  
> +static void validate_blend_mode_for_alpha_formats(struct drm_plane *plane)
> +{
> +	const struct drm_format_info *fmt;
> +	u32 i;
> +
> +	/* blend mode property supported, no need to check anything */
> +	if (plane->blend_mode_property)
> +		return;
> +
> +	for (i = 0; i < plane->format_count; i++) {
> +		fmt = drm_format_info(plane->format_types[i]);
> +		if (fmt->has_alpha) {
> +			WARN(1, "[PLANE:%d:%s] pixel format with alpha exposed but "
> +			     "blend mode not setup", plane->base.id, plane->name);

I am seeing this warning trigger on a few of my machines in -next. A
couple of those use amdgpu, which I see has already been reported in a
separate thread. Another one uses ast, which I do not see reported
(apologies if I missed it).

  [  +0.000137] ------------[ cut here ]------------
  [  +0.000004] [PLANE:37:plane-1] pixel format with alpha exposed but blend mode not setup
  [  +0.000019] WARNING: drivers/gpu/drm/drm_mode_config.c:873 at drm_mode_config_validate+0xa24/0xad0, CPU#0: kworker/0:2/507
  [  +0.000010] Modules linked in: ghash_ce gf128mul nvme ast(+) nvme_core sbsa_gwdt i2c_algo_bit nvme_keyring nvme_auth xgene_hwmon gpio_dwapb fuse scsi_dh_alua scsi_dh_rdac i2c_dev scsi_dh_emc
  [  +0.000014] CPU: 0 UID: 0 PID: 507 Comm: kworker/0:2 Not tainted 7.2.0-rc4-next-20260721-00002-g17fa9b81f4c4 #1 PREEMPT(lazy)
  [  +0.000003] Hardware name: To be filled by O.E.M Ampere Altra Developer Platform/Ampere Altra Developer Platform, BIOS TianoCore 2.10.100.02 (SYS: 2.10.20
  [  +0.000002] Workqueue: sync_wq local_pci_probe_callback
  [  +0.000004] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [  +0.000003] pc : drm_mode_config_validate+0xa24/0xad0
  [  +0.000002] lr : drm_mode_config_validate+0xa24/0xad0
  [  +0.000002] sp : ffff800082df3c30
  [  +0.000001] x29: ffff800082df3c60 x28: ffffde7ac3633fc2 x27: 0000000000000001
  [  +0.000004] x26: 0000000000000001 x25: 0000000000000002 x24: 0000000000000000
  [  +0.000003] x23: ffff07ffb54b0290 x22: ffff07ffb54b0be0 x21: ffffde7ac36ebb13
  [  +0.000003] x20: 0000000000000001 x19: ffff07ffb54b0000 x18: ffff800082dd5038
  [  +0.000003] x17: 00000000d949c370 x16: 00000000d949c370 x15: ffffde7ac358f156
  [  +0.000002] x14: 0000000000000386 x13: ffff081eeebf2850 x12: 0000000000000000
  [  +0.000003] x11: 0000000000000000 x10: ffffde7ac44b5850 x9 : 738b2a5f3c615c00
  [  +0.000003] x8 : 738b2a5f3c615c00 x7 : 0000000000000000 x6 : 206c65786970205d
  [  +0.000003] x5 : ffff081f6fcc917b x4 : ffffde7ac36ebb59 x3 : ffffffffffff0a00
  [  +0.000002] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 000000000000004b
  [  +0.000003] Call trace:
  [  +0.000001]  drm_mode_config_validate+0xa24/0xad0 (P)
  [  +0.000003]  drm_dev_register+0x44/0x3d8
  [  +0.000004]  ast_pci_probe+0x330/0x354 [ast]
  [  +0.000016]  local_pci_probe_callback+0x68/0xc0
  [  +0.000002]  process_scheduled_works+0x23c/0x668
  [  +0.000003]  worker_thread+0x218/0x324
  [  +0.000003]  kthread+0x130/0x180
  [  +0.000002]  ret_from_fork+0x10/0x20
  [  +0.000004] ---[ end trace 0000000000000000 ]---

If there is any other information I can provide or patches I can test, I
am more than happy to do so.

-- 
Cheers,
Nathan
