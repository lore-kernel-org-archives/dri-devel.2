Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE72606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3RQrBHt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7A21121A1;
	Thu,  5 Nov 2026 07:34:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D0D1121A1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:34:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EA7E413C7;
 Thu,  5 Nov 2026 07:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0431F00919;
 Thu,  5 Nov 2026 07:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793864061;
 bh=9S54c5hLaIqCX7gpCP2+w2yt+KFaGKMcYFS0qglRO1o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k3RQrBHtWnAr4dhv5Y71mMYe50dWkDY5+WW5UTEd9bH20MxykNzSyRSC7RYLJcV/o
 5vFgES/lShlPnoE/AIMC9pgj24bISbccH5bbYyxIbO7h9QQQ/3ppcc3Zp2EAQyjLCC
 5M+mk71YTSw9d0iRKlMa41cuuyMSy+tTJclvGWhrpSH4ZkTvJvhGEkr+ME+4h2RhTA
 pMbsFMujWVM6B20tsHfpnoX7Vc2kATFbnsyXuKByAhv8sylPwCoI6l0efRUooWY/WG
 5IDAI910XietoQdIVEW6LeJuUWTz8DcgOF92dSB+hlq7LKw5uhUZi1qwI5vrlAAjWM
 x+XWUcfMWqSOA==
Message-ID: <sashiko-outbox-198680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 07/13] media: uapi: cec.h: add
 CEC_CAP_HAS_HPD_PRESENT/CEC_LOG_ADDRS_FL_HPD_PRESENT
To: "Hans Verkuil" <hverkuil+cisco@kernel.org>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <4cd2dd652db11b7410a6f9608c5c15bef45f5df5.1793863347.git.hverkuil+cisco@kernel.org>
References: <cover.1793863347.git.hverkuil+cisco@kernel.org>
 <4cd2dd652db11b7410a6f9608c5c15bef45f5df5.1793863347.git.hverkuil+cisco@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:34:20 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] media: uapi: cec.h: unimplemented and undocumented HPD_PRESENT U=
API flags
- [Low] media: uapi: cec.h: mismatched EDID comment on CEC_LOG_ADDRS_FL_HPD=
_PRESENT
--

commit 2490741b0b49047176c24c5b5fcdf74889b9d347
Author: Hans Verkuil <hverkuil+cisco@kernel.org>

media: uapi: cec.h: add CEC_CAP_HAS_HPD_PRESENT/CEC_LOG_ADDRS_FL_HPD_PRESENT

This commit adds the CEC_CAP_HAS_HPD_PRESENT capability and the
CEC_LOG_ADDRS_FL_HPD_PRESENT logical address flag to include/uapi/linux/cec=
.h
to indicate whether HPD is present.

> diff --git a/include/uapi/linux/cec.h b/include/uapi/linux/cec.h
> index fdfc97a6e4ec0..b1b5f47485836 100644
> --- a/include/uapi/linux/cec.h
> +++ b/include/uapi/linux/cec.h
> @@ -325,27 +325,27 @@ static inline int cec_is_unconfigured(__u16 log_add=
r_mask)
>  #define CEC_MODE_FOLLOWER_MSK		0xf0
> =20
>  /* Userspace has to configure the physical address */
> -#define CEC_CAP_PHYS_ADDR	(1 << 0)
> +#define CEC_CAP_PHYS_ADDR		(1 << 0)
>  /* Userspace has to configure the logical addresses */
> -#define CEC_CAP_LOG_ADDRS	(1 << 1)
> +#define CEC_CAP_LOG_ADDRS		(1 << 1)
>  /* Userspace can transmit messages (and thus become follower as well) */
> -#define CEC_CAP_TRANSMIT	(1 << 2)
> -/*
> - * Passthrough all messages instead of processing them.
> - */
> -#define CEC_CAP_PASSTHROUGH	(1 << 3)
> +#define CEC_CAP_TRANSMIT		(1 << 2)
> +/* Passthrough all messages instead of processing them. */
> +#define CEC_CAP_PASSTHROUGH		(1 << 3)
>  /* Supports remote control */
> -#define CEC_CAP_RC		(1 << 4)
> +#define CEC_CAP_RC			(1 << 4)
>  /* Hardware can monitor all messages, not just directed and broadcast. */
> -#define CEC_CAP_MONITOR_ALL	(1 << 5)
> +#define CEC_CAP_MONITOR_ALL		(1 << 5)
>  /* Hardware can use CEC only if the HDMI HPD pin is high. */
> -#define CEC_CAP_NEEDS_HPD	(1 << 6)
> +#define CEC_CAP_NEEDS_HPD		(1 << 6)
>  /* Hardware can monitor CEC pin transitions */
> -#define CEC_CAP_MONITOR_PIN	(1 << 7)
> +#define CEC_CAP_MONITOR_PIN		(1 << 7)
>  /* CEC_ADAP_G_CONNECTOR_INFO is available */
> -#define CEC_CAP_CONNECTOR_INFO	(1 << 8)
> +#define CEC_CAP_CONNECTOR_INFO		(1 << 8)
>  /* CEC_MSG_FL_REPLY_VENDOR_ID is available */
> -#define CEC_CAP_REPLY_VENDOR_ID	(1 << 9)
> +#define CEC_CAP_REPLY_VENDOR_ID		(1 << 9)
> +/* CEC_LOG_ADDRS_FL_HPD_PRESENT is available */
> +#define CEC_CAP_HAS_HPD_PRESENT	(1 << 10)
> =20
>  /**
>   * struct cec_caps - CEC capabilities structure.
> @@ -405,6 +405,8 @@ struct cec_log_addrs {
>  #define CEC_LOG_ADDRS_FL_CDC_ONLY		(1 << 2)
>  /* Configuration failed */
>  #define CEC_LOG_ADDRS_FL_CONFIG_FAILED		(1 << 3)
> +/* EDID is present */
> +#define CEC_LOG_ADDRS_FL_HPD_PRESENT		(1 << 4)

[Severity: Medium]
Are CEC_CAP_HAS_HPD_PRESENT and CEC_LOG_ADDRS_FL_HPD_PRESENT missing their
kernel implementation and documentation?

Neither symbol is referenced anywhere in the kernel tree or documented in
Documentation/userspace-api/media/cec/cec-ioc-adap-g-caps.rst and
Documentation/userspace-api/media/cec/cec-ioc-adap-g-log-addrs.rst.

When userspace calls the CEC_ADAP_S_LOG_ADDRS ioctl, cec_adap_s_log_addrs()
strips CEC_LOG_ADDRS_FL_HPD_PRESENT before calling __cec_s_log_addrs():

drivers/media/cec/core/cec-api.c:cec_adap_s_log_addrs() {
	...
	log_addrs.flags &=3D CEC_LOG_ADDRS_FL_ALLOW_UNREG_FALLBACK |
			   CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
			   CEC_LOG_ADDRS_FL_CDC_ONLY;
	mutex_lock(&adap->lock);
	if (!adap->is_claiming_log_addrs && !adap->is_configuring &&
	    (!log_addrs.num_log_addrs || !adap->is_configured) &&
	    !cec_is_busy(adap, fh)) {
		err =3D __cec_s_log_addrs(adap, &log_addrs, block);
	...
}

Nothing in the CEC core or drivers ever sets or checks
CEC_CAP_HAS_HPD_PRESENT in adap->capabilities or CEC_LOG_ADDRS_FL_HPD_PRESE=
NT
in adap->log_addrs.flags. Should these UAPI definitions be introduced
together with the kernel code and documentation that use them?

[Severity: Low]
Is the comment "EDID is present" above CEC_LOG_ADDRS_FL_HPD_PRESENT intende=
d?
The macro name and commit message both describe indicating whether HPD is
present rather than EDID.

Also, this isn't a bug, but the patch re-indents all existing CEC_CAP_*
definitions with an extra tab to align their values, while the new
CEC_CAP_HAS_HPD_PRESENT uses a single tab and leaves `(1 << 10)` unaligned
with the rest of the block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4cd2dd652db11b7410a=
6f9608c5c15bef45f5df5.1793863347.git.hverkuil+cisco@kernel.org?part=3D1
