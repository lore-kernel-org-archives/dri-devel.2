Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B72CD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 07:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A9810E131;
	Tue,  9 Jun 2026 07:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=asu.edu header.i=@asu.edu header.b="OcGVUvor";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0E210E0DF
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 06:42:20 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-c8585ecdd71so1813192a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 23:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780987339; cv=none;
 d=google.com; s=arc-20240605;
 b=CwtYYlmsYBt4m8+yiKOy4q+6R9stHhcZu6YK3vENj0m6I2IWKTMkBwXFB2W3KxkM1x
 plC4asDakUJXpS6wRXjIzbfsfSqEJT4mIY06i3LfGLnO2Q+/yhXig2is5Fjd7Fynms4a
 wszenQKRcOFKparrzbgc4mK3hu3pixqH+f53Fdaxt1rFEsqiciKh8S6Dmsx6V105RX0N
 zMfaNfFBF7ff/UQ0OojPGUfYiMxUbofzlvUrOYhT+tp4CKRyvPaHj17qViPgojPF86Y7
 o2dwS478UnGbPWQRMVAU1I1OX3174zxTO6VGJzZhFjdbqvBMsAtDoDCQz3ZhyE4KEC0o
 IOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZCLBpvewrQc5iSbRkngzj4n3bbmvujjZNz9E1NnWUQQ=;
 fh=vnxmWGAYe07lDWvBLy99135o+eX/hoHAELEu7csD4sA=;
 b=gCQF0sbZDPr1QJc2azL5z0SGgx1SlpGOW+9y+0he8bXVr4lp26v41M4HZ1ypgYLt5X
 CM+gVOP4GEgjczk3QvoIAWYwjpi11yiPpiZP0rPWaMZObLAJb626IfPT9Tzv4HFL8wDe
 q06Yz1M449Z0rF5Bc3QMC9+5MBzRGJgH+qhEFf2DxmhEHs2lG2Y9S7GmfzmYqxIE5UbA
 moEaTPRTMJUljegrvKnloioo/zfeF9m/A0XrRoloqxfSV+aX/I+ZuY0pvpRPaJ6X0OUG
 Mj6sa+rtuccLjQrxZzg81ZiNFHamEhNeYtL8/GzM+Bgoj/4azKrhvxF2zUxDXGM7B8v+
 48Nw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=asu.edu; s=google; t=1780987339; x=1781592139; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCLBpvewrQc5iSbRkngzj4n3bbmvujjZNz9E1NnWUQQ=;
 b=OcGVUvorGDty4NYphSoVZBeMMhkLv6puOJcSycQKWY0pPpQaUdHauJQ2FsXFMdwAiN
 +n7/fDwbjYTY0Tfhj9weRNJekvfIcaAuN51iF229NJ6fTyvQACvOYrrD0nu7u6mZ12GB
 r83AyFN+beBzridSZbzGcGH/OScZkCXLH30zqVhosruUg/HfOl9/xM/ZE32gMdV7mGs5
 drxkv7ohfYPlfZWkuSZvkQ1mih6YiTUG80es/MYnbUJsNX7c0Tt25EgINvNVC6R7Qgd5
 +wLGH9BM9th0Wk1Kk3QoSNBaemPd6EZDsXe0JzWkIra3xEuxIxgdWs6NY4M6qJhC8QCm
 ZkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780987339; x=1781592139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZCLBpvewrQc5iSbRkngzj4n3bbmvujjZNz9E1NnWUQQ=;
 b=GZj6xBwsls8VGe+ray9SXqCAiC54IPSQK2gnK5hDQNUiaXSq3AYW9GHLTQqc3MJeJ5
 7HlgX9/bHKpHb1v+vGNIuT8Pam9mEm9ECzQ1T053gp6WHDgpCW4eZPQ5mRz1Pq1+T9v+
 XNETTfYIkluC7pcd7HdjfOOPNancZVTp4vbkV3pemfWmm0zMgnUNiHV+TJUChb0dB97s
 xo66PAEfuTJejxhK9vRr1EDGDLrCyft6Rbp7rFrkHixEz77gq8YSCiOBgY2SkKV+9Nnr
 YVAQhYOmMn91bnN6osnGlhj58DKyGANU626sjXMeAFTcIZR4BAFQaK5gQxXX7OZIkxpd
 4beQ==
X-Gm-Message-State: AOJu0Yx+8WW/TwscOccWGjaiqCZNvkEkr4X5u1G5IC/WTSvbHdoJaf7H
 uie4y2Jt6kdYXkH5E/QYD8VglbdrkoQv7xmOtAnQ6Q6LmlwIwAnqopEg0da7C/K/p/jV6RPU2al
 77opzIVXaijYxLFcsJhKh8vruqd3HtqbjKWdG3Siv53337bW62+8cZVQcVkA=
X-Gm-Gg: Acq92OFHs8Pz16f1sgwLxc2j9OT4FHmtpKblKl19x9wtr0Ys88ASkkPl4nAhR7tacbM
 4gFSabR0wEIg845XqhfDNPwlhkQCiMNp83VQgjaOBLFq8oR968TmwFGSD3vQ0GzC1KDtnV/mJNy
 Htyle4p0pBPti+gDO55DfsxwF4LqQVzD9Lla0sfHQFPPVlJ/OyyFIN5pVde5C5k95v4e4Y0xOxp
 GifXtqnH057zwUY9fBmnD6/Y5ocv2jxVoCKDOWarcfKiypBe2+qCzWdSnd+sTwv6nSt5wIBW1Ea
 H9qNRGvFFUyeVQXoyg==
X-Received: by 2002:a05:6a20:2f98:b0:3a2:dc51:458 with SMTP id
 adf61e73a8af0-3b4cd02f653mr21663714637.41.1780987339408; Mon, 08 Jun 2026
 23:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260609064038.2799482-1-xmei5@asu.edu>
In-Reply-To: <20260609064038.2799482-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 8 Jun 2026 23:42:08 -0700
X-Gm-Features: AVVi8CeaiQSzdH1DPldEyDtDM6MMjh3M_YMQFH0A0HGIuDiaZqFxV5lkg2LemC8
Message-ID: <CAPpSM+T2auTggQK76onPAPvtq1mAJ5bsuvVBQpWEAEWts0C5KQ@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: fix OOB read in drm_parse_tiled_block()
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 09 Jun 2026 07:16:14 +0000
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

Thanks for your attention to this bug. We have a PoC that can trigger
the KASAN crash. Please DM if you need it to reproduce the issue.

This is a bug that enables the kernel info leak for an attacker with
physical access.

Xiang

On Mon, Jun 8, 2026 at 11:40=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> drm_parse_tiled_block() casts the DisplayID block to a
> struct displayid_tiled_block and reads the full fixed layout up to
> tile->topology_id[7] without checking block->num_bytes. The DisplayID
> iterator only validates the declared payload length, so a crafted EDID
> can advertise a tiled-display block (tag DATA_BLOCK_TILED_DISPLAY, or
> DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY for v2.0) with a small num_bytes at
> the end of a DisplayID extension. The read then runs past the end of the
> exact-sized kmemdup()'d EDID allocation, a heap out-of-bounds read.
>
> Add a minimum-length check, as drm_parse_vesa_mso_data() already does.
>
>   BUG: KASAN: slab-out-of-bounds in drm_edid_connector_update
>   Read of size 2 at addr ffff888010077700 by task exploit/147
>    dump_stack_lvl (lib/dump_stack.c:94 ...)
>    print_report (mm/kasan/report.c:378 ...)
>    kasan_report (mm/kasan/report.c:595)
>    drm_edid_connector_update (drivers/gpu/drm/drm_edid.c:7581)
>    bochs_connector_helper_get_modes (drivers/gpu/drm/tiny/bochs.c:574)
>    drm_helper_probe_single_connector_modes (drivers/gpu/drm/drm_probe_hel=
per.c:426)
>    status_store (drivers/gpu/drm/drm_sysfs.c:219)
>    ...
>    vfs_write (fs/read_write.c:595 fs/read_write.c:688)
>    ksys_write (fs/read_write.c:740)
>
> Fixes: 40d9b043a89e ("drm/connector: store tile information from displayi=
d (v3)")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/gpu/drm/drm_edid.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 404208bf23a6..92054ac82fe2 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -7575,6 +7575,13 @@ static void drm_parse_tiled_block(struct drm_conne=
ctor *connector,
>         u8 num_v_tile, num_h_tile;
>         struct drm_tile_group *tg;
>
> +       if (block->num_bytes < sizeof(*tile) - sizeof(*block)) {
> +               drm_dbg_kms(connector->dev,
> +                           "[CONNECTOR:%d:%s] Unexpected tiled block siz=
e %u\n",
> +                           connector->base.id, connector->name, block->n=
um_bytes);
> +               return;
> +       }
> +
>         w =3D tile->tile_size[0] | tile->tile_size[1] << 8;
>         h =3D tile->tile_size[2] | tile->tile_size[3] << 8;
>
> --
> 2.43.0
>
