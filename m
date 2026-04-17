Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4DEF8E4A7
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5EB410E106;
	Fri, 17 Apr 2026 04:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y9Vjn8q4";
	dkim-atps=neutral
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7892E10E106
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 04:36:12 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-89fc4147f2eso3009326d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 21:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776400571; x=1777005371; darn=lists.freedesktop.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wJCWVp8OC7bbbAgdbMwdNkUeylvTtEVIhbLpUvTx1Rk=;
 b=Y9Vjn8q46aFuUaOasaLmyIHepBaiMfH4Si7JUZKLTvmilciLU8UPiBl/vBjBk+g6Ts
 E+40wLexVcsZiJ4WFjQrHiYL0Cq9Zjx0hwcEXUU0Zcu01KH/OXIrpCY1heAL/SDMgnAw
 NLIwPmtKDmmnZZgHJLWb39pEoyUPJcaFDPENwxSO7cSDslpqQLZ7wHrNPLy/5SLaRcQg
 Xo1szlhbH3XRAHYZnMfEb9XX+7JS2jPYfeS3AI/+3EcM8pb/Pt6DnUmqQcEsOhW3fYOK
 FAbq3doVUBLuRj72jQAv9KRgflfMQKO2P82Ul6lqmwKc4CWg9+0G84um/81BryJJG3ia
 voVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776400571; x=1777005371;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wJCWVp8OC7bbbAgdbMwdNkUeylvTtEVIhbLpUvTx1Rk=;
 b=YZinD5JiWIsGXChpF80w1a/gNu5Pr93+njB/YTgQAvMjJbkpx/NM6Q1k1RRmNiJLOs
 YIPnZnBiK8xrhAuWfH1uw7S2M3TNOwi8FC8QvI79A+/DG7xm1oWOcLVyQVYqy/Pu2VP9
 53FOypCvwuFot/3JEuwfQEa8c0ojWUaIT819knDaTNbRxwN6UMtsVQV7LwJ1xx8a+Vbz
 D/D/Hb8X34o35phZ6gesPyswSLS9ohiaoEQvNDh0LNGtFCY+xQGSVYLV7otdlqaTenF8
 Ju/jNFu4e6cp5ef92+Rsi9IA/Nlt7O27RkqfCIplkFDCZtubPN3HOxR7uPszebmCVkvX
 Zzqg==
X-Gm-Message-State: AOJu0YzsvHUxFjM1yoreDX3/zYXaBzfElrMvKgiPLw5RL+xow8WuvgW/
 TcVXcaogfc6KizIA9ZnSN/onJSKLV/KIa6dvgd9uJIoY34aR/R/Fgfyf
X-Gm-Gg: AeBDiesMjj3r9qckpnkJE8rL8QEBt0w1HmiNmw0gL6P1PFTbi/8W/ywE0rV/bq39qmy
 emb3SeuBYpFM2NSMZHpagELAgwOgs6haCTanS5h4Qw/TygOg1lVExWCTS0qJOxBY5QKJcPN+eDh
 DfW0ScsqGtpP6jv+Ewu5N2w1isx9smgKfKIaxkgwc0ZrmojSZXNm9kcLTrVlmeCNLteYqPiEtAC
 BV2QX4m6VdxoMT6Fvib9dnD3tJTfAKQR20m1ZkFlES2tolO3qAUEeQgvxGICOCKwrJs5UtfIemb
 Ju4B9GMo4njFDSvi31DnAA+9shBOnmjgwNWnxdtFx2ifJhIBs6lptDF9839tJUTwfleQ5E7R92s
 mKjuOrkdlloDnd51X0pxpcp5IGhVQ5/9T6K2WKhh5U5Z1PHIF3kPxmd8s3f8xeqDiRO+KpvmM1L
 MxYF44c4GJ1+ohn5DlaacWEsfKTjwDXCYu7TQ7AMCWHdG6OhMk
X-Received: by 2002:a05:6214:4a08:b0:89c:ac72:2f6e with SMTP id
 6a1803df08f44-8b02813f8e0mr21757356d6.43.1776400571385; 
 Thu, 16 Apr 2026 21:36:11 -0700 (PDT)
Received: from [192.168.2.25] ([184.146.175.99])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac72915sm2745626d6.15.2026.04.16.21.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 21:36:10 -0700 (PDT)
Message-ID: <7b4509b0-9c35-40ca-9388-881236c82a32@gmail.com>
Date: Fri, 17 Apr 2026 00:35:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101
 Thunderbird/136.0
Subject: Re: [PATCH v2 1/2] drm/sched: Make drm_sched_entity_kill() a public
 function
To: Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Dave Airlie <airlied@redhat.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260415144956.272506-2-phasta@kernel.org>
Content-Language: en-CA, en-US
From: Luben Tuikov <ltuikov89@gmail.com>
Autocrypt: addr=ltuikov89@gmail.com; keydata=
 xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1APnbnnRHN
 Ikx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoAQRYhBJkj7+VmFO9b
 eaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheA
 AAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlTMqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfy
 JwktF7REl1yt7IU2Sye1qmQMfJxdt9JMbMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSP
 cCE8uGe7FWo8C+nTSyWPXKTx9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl
 10wVR5QxozSvBQJlOiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKo
 aMDzO9eGz69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA==
In-Reply-To: <20260415144956.272506-2-phasta@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tyfpZ8tXo0NFX30pwA0Og5IZ"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tyfpZ8tXo0NFX30pwA0Og5IZ
Content-Type: multipart/mixed; boundary="------------gaPimzysG4nviCSPOZwz55y1";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Philipp Stanner <phasta@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Dave Airlie <airlied@redhat.com>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-ID: <7b4509b0-9c35-40ca-9388-881236c82a32@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/sched: Make drm_sched_entity_kill() a public
 function
References: <20260415144956.272506-2-phasta@kernel.org>
In-Reply-To: <20260415144956.272506-2-phasta@kernel.org>

--------------gaPimzysG4nviCSPOZwz55y1
Content-Type: multipart/mixed; boundary="------------5h2gFf0j1Vd2PHE5Iw2i7zdd"

--------------5h2gFf0j1Vd2PHE5Iw2i7zdd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2026-04-15 10:49, Philipp Stanner wrote:
> Some drivers do not care on teardown whether the last jobs pending in a=
n
> entity are actually executed before teardown completed. For such
> scenarios, drm_sched_entity_flush() is not the ideal function since it'=
s
> intended to wait for jobs to complete.
>=20
> Make drm_sched_entity_kill() public for that use-case and update the
> documentation.

This is a good patch and great suggestion by Danilo.

>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> Changes in v2:
>   - Improve wording, fix typo.
> ---
>  drivers/gpu/drm/scheduler/sched_entity.c | 13 +++++++++++--
>  include/drm/gpu_scheduler.h              |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm=
/scheduler/sched_entity.c
> index 61a4818cc87b..7be5811b90cd 100644
> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> @@ -267,8 +267,16 @@ static void drm_sched_entity_kill_jobs_cb(struct d=
ma_fence *f,
>  	schedule_work(&job->work);
>  }
> =20
> -/* Remove the entity from the scheduler and kill all pending jobs */
> -static void drm_sched_entity_kill(struct drm_sched_entity *entity)
> +/**
> + * drm_sched_entity_kill - kill an entity's pending jobs and remove it=

> + * @entity: the entity to remove
> + *
> + * Removes the entity from the scheduler's run queue and kills all pen=
ding jobs.
> + *
> + * This function should be used over drm_sched_entity_flush() if it is=
 not
> + * desired to actually wait for all pending jobs to finish.
> + */

I felt that the email body above describing this patch was somewhat clear=
er. Perhaps something like:
(Notice the change "if" --> "when".)

"Use this function over drm_sched_entity_flush(), when the caller is not =
interested to wait
 for pending jobs to complete. This function kills any pending jobs."

--=20
Regards,
Luben

--------------5h2gFf0j1Vd2PHE5Iw2i7zdd
Content-Type: application/pgp-keys; name="OpenPGP_0x4C15479431A334AF.asc"
Content-Disposition: attachment; filename="OpenPGP_0x4C15479431A334AF.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZTohOhYJKwYBBAHaRw8BAQdAWSq76k+GsENjDTMVCy9Vr4fAO9Rb57/bPT1A
PnbnnRHNIkx1YmVuIFR1aWtvdiA8bHR1aWtvdjg5QGdtYWlsLmNvbT7CmQQTFgoA
QRYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJlOiE6AhsDBQkJZgGABQsJCAcCAiIC
BhUKCQgLAgQWAgMBAh4HAheAAAoJEEwVR5QxozSvSm4BAOwCpX53DTQhE20FBGlT
MqKCOQyJqlMcIQ9SO1qPWX1iAQCv3vfyJwktF7REl1yt7IU2Sye1qmQMfJxdt9JM
bMNNBs44BGU6IToSCisGAQQBl1UBBQEBB0BT9wSPcCE8uGe7FWo8C+nTSyWPXKTx
9F0gpEnlqReRBwMBCAfCfgQYFgoAJhYhBJkj7+VmFO9beaAl10wVR5QxozSvBQJl
OiE6AhsMBQkJZgGAAAoJEEwVR5QxozSvSsYA/2LIFjbxQ2ikbU5S0pKoaMDzO9eG
z69uNhNWJcvIKJK6AQC9228Mqc1JeZMIyjYWr2HKYHi8S2q2/zHrSZwAWYYwDA=3D=3D
=3DqCaZ
-----END PGP PUBLIC KEY BLOCK-----

--------------5h2gFf0j1Vd2PHE5Iw2i7zdd--

--------------gaPimzysG4nviCSPOZwz55y1--

--------------tyfpZ8tXo0NFX30pwA0Og5IZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCaeG4rgUDAAAAAAAKCRBMFUeUMaM0r6j4
AQDr7lP/kQhrH/SqboZz98qXO5P5Ea7iUmqRubR6r9+G/gEAqaquNDOvBw2OUFmYIobPxbdWZ2if
glf+8pI8YLWZ9g0=
=vuh+
-----END PGP SIGNATURE-----

--------------tyfpZ8tXo0NFX30pwA0Og5IZ--
