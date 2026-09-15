Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE91AC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 227F810E729;
	Tue, 15 Sep 2026 14:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m+T/9clt";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A060310E729
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:14:15 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-97cb5c91d5fso92838241.2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 07:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789481654; cv=none;
 d=google.com; s=arc-20260327;
 b=Jym91XpgAxBDHeGCtJMIPLoNm3bW0ogtvgnh2wmBTKrtsJVtY53LWo3DhrDJRuaIv1
 UpfnkHwBUwwcpBAAdzfA8Jo0BJftF4PNxF2DH2FBGxaspEzK5FX0h9ohU/6vjLI1OpZF
 UEIiQUpo1CSGq/22SlAGCc/AoyomJUj+ESP1NsHHP3h7zEGnDK4+gJtc3LAsAxHNXB2u
 A6NUFBu3O8BTGWwXHc7feK7lFseNyZiyHcjrijZkGVs09J+BNKpB22zfURAjE9ms9C4U
 lVq+7k/v6w2Q0XtNtPov7m4t+OQgHSnDm2MqnHayk+uQJrhKcjMC2QbinxE6DMRGd370
 TcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RWQQ16n/Y9tSUunBn+e/2NyOzrUzmECVOOglAlx98Qs=;
 fh=+rrGUeytct41xfV45eovThXT1PxI8Yg25Dg8yRTbbhw=;
 b=W2kUARZLTVsx0xEqfNXwy879QDM3YFpTfOb1rA0s7bkJhyB0YeRHKtNZJxXNQVHlMo
 ODYt+VnF8U6911eeagH8x+7a6bEFs5u84LVbfrzLYLJJht/RwkVrhklYuyMsA1EG8fFB
 8G0o3eKHSATu8q6DDF6ftjoo1r1X73kARoNAe/VOojdLicp1WhWtbD/BRK9O8+5fR4lr
 8xSUnd6hv1/do+3ud3mH5HZQ07LMlcN/XMuZBb8hQaUayqQJecCvE9m6ED5BsScT25Ui
 hTH1/7/+G2mOJs6XPq16vqPY6ymONxZa7jqUbZ68nxb9ZR3fj+exSad3lmiOG6G/NZbL
 KNSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789481654; x=1790086454; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RWQQ16n/Y9tSUunBn+e/2NyOzrUzmECVOOglAlx98Qs=;
 b=m+T/9cltNFEby0DGH7HrhSNnhCSGKWYy0CvDe93fwJ+/Q4EE5DRSXwXGUZfIu7FK6C
 I4oET58y6z18quenAvHbwx5f5TYgV1LwjiaGVEhxK/iGQJJPxuwCHrqe/1Nq+f5e9WX4
 VPjAV3Jr8F2SREihYo/hRW18j5bCvdj5Mlmq7xCgXjki9cFj8Z1bJW0w7vxjWOou77h9
 VGMeTR+Hj/B5rs/GLuAXAM8Omt4CmwHmLNWRTENRKXyUnwpH0MnTNxdNc9Mcl2CdUkNg
 KKZiZokn0pCNEvt/JljA21TPg22mkdZBFVSK9z3IZD9Rhfn5Ao+xY5gotiSJVBZsU8rG
 /tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789481654; x=1790086454;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RWQQ16n/Y9tSUunBn+e/2NyOzrUzmECVOOglAlx98Qs=;
 b=y1vwUfDxvYUznr757AFAFWog70wADiMbyEbCbXQH1I87+Z3aj7b/X9k6JiNb//J8Gs
 Up9xKq+vCDv3K7gL8+ggDPZvm8eJuOM/hcZk0+E9l03s/1ODY13GTiRaU2ALDYqn3j1H
 mg/8GmXTxRuzaMMdK8YCq5pG0IY+irm7MLONc4sxA61/P4O8jf51L80fo8rL7XIZ//IJ
 xcp/KeaeiTio6Yk7H05LypGIFuUtPzkR4yRa6I7eRxcg1EkeQZHPjaq3XEVnnvMSQMQ9
 KdKeQGLNSqIrncN6Iaiv511IrhsQtOrHV00aFR0ahc/IrKcHmuwU2Q4hlzqqCuxqz4Hq
 dDIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjbjdfbt1/Rt8Vmqp6EPiRvtL31tvC0eeZUnRY9r+WUGztTz1+U5QV4j9euXZSAU/Cd7NXmiPbDjI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mUufX8NPrn+pOFucyw0qcGoTV9fjqXnSbEDUaRQQxwcIfvT6T4
 pz35GvzAZhhQAGK0C2KFtBqL6SplJ8k2aDeUPITtfk7mX2UIV5cW+RF4IB+q4E+K49JUMtUb0wb
 WbTPaFSvBO37DR1g+KKEd1vKqj4mTq2w=
X-Gm-Gg: AYBFou2kyQDipqJ/njOcUSW5XamCA6ne8qmvqHRlVw+1d3LBhRW/L6LEHAUvhtRHMB2
 DTxnsoiuye8TV9XaPa6cuZFLTTxjqGF3XWQeEuSHrm3tOvXfnRR8Vn3RevnCb9Hq6KW07lhqccR
 p4W24sr4GzHBQMkz1MpxSzzCMX6ZfNBntIg5S+CBP9Zms2kkOMv0a/NPl/fokxcNxkor2SjOXfL
 AFwjIhk+IpTb89fJLZOLwilmwBnMPSPzRaUTbnpuojaQ45QfP/3qp+3Dwb5RrEGGdEgfi9gvczI
 Nrtb09QxK4+78c8+yA8Z6eJNi1AijIGbZgOI8Q6KyEqC2vOEjpnNYmXcTtCUSXZI3Jqud4X0H54
 5gAaUADyne0Gj4nOWhOYyfuSFU7l2yVHI7oRcOAsIIA==
X-Received: by 2002:a05:6102:54aa:b0:795:41a8:ff58 with SMTP id
 ada2fe7eead31-79b53156063mr2222470137.0.1789481654462; Tue, 15 Sep 2026
 07:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260915005421.20570-1-emmaonana18@gmail.com>
In-Reply-To: <20260915005421.20570-1-emmaonana18@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 10:14:01 -0400
X-Gm-Features: AcwNN1XCYqnubKV6DPknJ8VP8xcUX59hQZqAGMsqaqTYwSEti10uZRVGJHGdrc8
Message-ID: <CADnq5_Orei9+6ZjCC2jTt8jrPM+w6jx5i1WoLxZWj9treOdzXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix kernel-doc warnings for
 amdgpu_display_manager
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, harry.wentland@amd.com, sunpeng.li@amd.com, 
 siqueira@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, alex.hung@amd.com, 
 bhawanpreet.lakha@amd.com, Wayne.Lin@amd.com, ivan.lipski@amd.com, 
 matthew.schwartz@linux.dev, Jerry.Zuo@amd.com, chiahsuan.chung@amd.com, 
 chen-yu.chen@amd.com, skhan@linuxfoundation.org, me@brighamcampbell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

Alex

On Tue, Sep 15, 2026 at 3:41=E2=80=AFAM Omokefe Emmanuel Onanaroghene
<emmaonana18@gmail.com> wrote:
>
> scripts/kernel-doc reports missing and excess member descriptions
> for struct amdgpu_display_manager:
>
>   struct member 'power_module' not described
>   struct member 'hdmi_frl_status_polling_wq' not described
>   struct member 'hdmi_frl_status_polling_delay_ms' not described
>   struct member 'boot_time_crc_info' not described
>   Excess struct member 'dm_boot_time_crc_info' description
>
> Add @power_module to the main struct doc, document
> hdmi_frl_status_polling_wq/work/delay_ms with separate inline
> comments, and rename @dm_boot_time_crc_info to @boot_time_crc_info
> to match the actual member name.
>
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 3524931451c8..61756c089fcc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -330,6 +330,7 @@ struct hpd_rx_irq_offload_work {
>   * @backlight_link: Link on which to control backlight
>   * @backlight_caps: Capabilities of the backlight device
>   * @freesync_module: Module handling freesync calculations
> + * @power_module: Module handling power calculations
>   * @hdcp_workqueue: AMDGPU content protection queue
>   * @fw_dmcu: Reference to DMCU firmware
>   * @dmcu_fw_version: Version of the DMCU firmware
> @@ -716,16 +717,26 @@ struct amdgpu_display_manager {
>                 char reply_data[0x40];  // Cannot include dmub_cmd here
>         } fused_io[8];
>         /**
> -        * @hdmi_frl_status_polling_work:
> +        * @hdmi_frl_status_polling_wq:
>          *
>          * workqueue for 200ms frl status polling
>          */
>         struct workqueue_struct *hdmi_frl_status_polling_wq;
> +       /**
> +        * @hdmi_frl_status_polling_work:
> +        *
> +        * Delayed work for 200ms HDMI FRL status polling.
> +        */
>         struct delayed_work hdmi_frl_status_polling_work;
> +       /**
> +        * @hdmi_frl_status_polling_delay_ms:
> +        *
> +        * Delay, in milliseconds, between HDMI FRL status polls.
> +        */
>         unsigned int hdmi_frl_status_polling_delay_ms;
>
>         /**
> -        * @dm_boot_time_crc_info:
> +        * @boot_time_crc_info:
>          *
>          * Buffer info for the boot time crc.
>          */
> --
> 2.43.0
>
