Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1197DF8E499
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4646A10E1E6;
	Fri, 17 Apr 2026 03:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ByysIorp";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3969110E1E6
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 03:54:31 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso45144285a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 20:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776398070; x=1777002870; darn=lists.freedesktop.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H5nrjef/FNz3f6JHFm8YF5SJcuEuUksqxelV8c7Plq0=;
 b=ByysIorp4qg/mlIoF6kxtsOIIGG22h8ZDquQUdhX+w05yPcDSPfH5xXcpeEr0U1VN1
 lDp2BrmKe4zBn6DDrONFbt71Ewjfado05uahVMj6WmNrznLaWPpRBXLZV/k9OqHkEtYg
 KSfX37j7hOkrky3xysSLdZrS/XAf/OPQkMPIytXVQCzkzLFdZ7bn+142C6+96uwA2HtW
 pZXAuiKadisjJvbpdo9UfXgq3mYhR5xU+P1ygLpedjTF+93yrU+5p7n0Qjd3GiTx2tFl
 +tPOAtbnid41z9opzrPic1rQ79ynDTZ/1CA70JvtPWAZQhOny/ln9BFPAJfyWanqbLTd
 V7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776398070; x=1777002870;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H5nrjef/FNz3f6JHFm8YF5SJcuEuUksqxelV8c7Plq0=;
 b=CxoMrO6/2RkqGuuk6/QJjozz2FDhJuDxH5TYnm+1ulrPsCTvNuEzFl7oDKhOxbGDzj
 xX+aRXiqwy3Bu4IgCDInWQl90Mq8gziaUyS5y4ZfiencsKAlxZAtvgvTl1oDLIFNITKn
 mqOLq3moWSdKh/76CMLGUV5aZa8FxOS4ZIxv8pVIjCLZpPNRujQ/MGFHAjOCi3uwqREi
 BWajkfi8sfI9rcsR900QDdNmHgOEezUxwhtUFbIyas/NIjtwmHrNv71sbxMk4ay7W18n
 l4BY14LFXq9BCI9OCMfkrmG2KsQ1wYw2c1t143K7jhyWRJFOtoO1xGG5z2jUFSp7H8IM
 blIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ou4qlYD3VIAjeTPo8vSQAZC9XDkTE3X33PrwAhvj1kClFV8eBYBlwi7JQ2sMx5Bk2r7spCuQE7q0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWY23yIx5od8ubMyj4MqqwvCWSke24YM7iUG7rwuymsVftlFCN
 8OxvvH0xYEMqgEt+h96xlLeIaTIWckXzX3dY4fWPnR+FDKq2zx0kmBmX
X-Gm-Gg: AeBDievd9OFBofzKU5EsRfampPGRarpbMC08efre6klAM5bgG/yaVjBEnDWA26y3/+i
 N4hSrS7y+CZbfdvwe2SB4s7y3a0hAMEdzGDdLlIKI+pyXiZHMbHIpcSpbY7mmAyJqszW2rNWUFC
 tV/GYc2vVhnY9Xop7rKEd2Sk04xhQLneGR3CoxfbDfrZ2YyiDF9ZF91SQ8xacWp6pG3JK5AE6xT
 YPveN1Fz45NOpYhifOaS35R7K/3erymj6Yj0kWX21aA5FA7jnyueAS3f7NXeyojZtNjQM0bEMtE
 MUPiVmjmerFqL5BvOYyYyU3J8M6U+jiLIimTsi9pjjdDw+IrP6jI6AS4qtDbMnpmyl3n9J3Z4Zw
 c2KY9YWc1huqwAQVr79MDd7zAQDWycFeVYlkuOYiBrFSXEx4dkyzeTEpj54ulhoWue9/oeoh7/N
 aYZmS20dxoMwysk81Am/3c8t560JDXIm8ieuYyZfHnw/e2oCzS
X-Received: by 2002:a05:620a:7083:b0:8c9:fb69:e708 with SMTP id
 af79cd13be357-8e78fd216d0mr145680285a.25.1776398069972; 
 Thu, 16 Apr 2026 20:54:29 -0700 (PDT)
Received: from [192.168.2.25] ([184.146.175.99])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d64cbbdbsm22553685a.12.2026.04.16.20.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 20:54:29 -0700 (PDT)
Message-ID: <4fd08215-c9f4-493f-ac49-141e9a486b02@gmail.com>
Date: Thu, 16 Apr 2026 23:54:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:136.0) Gecko/20100101
 Thunderbird/136.0
Subject: Re: [PATCH v8 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, srini@kernel.org,
 linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 andersson@kernel.org
References: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
 <20260415112530.4083240-5-ekansh.gupta@oss.qualcomm.com>
 <8dc8c094-63ab-4f9c-867a-96b615dff2cf@gmail.com>
 <90c2f6d5-21cd-4ba1-86e4-458100c8f830@oss.qualcomm.com>
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
In-Reply-To: <90c2f6d5-21cd-4ba1-86e4-458100c8f830@oss.qualcomm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------u6hXa02bmrzTrAKCf5rbNvPB"
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
--------------u6hXa02bmrzTrAKCf5rbNvPB
Content-Type: multipart/mixed; boundary="------------q7nzm1aCz6wjRQL5UEw8NoVY";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, srini@kernel.org,
 linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 andersson@kernel.org
Message-ID: <4fd08215-c9f4-493f-ac49-141e9a486b02@gmail.com>
Subject: Re: [PATCH v8 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
References: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
 <20260415112530.4083240-5-ekansh.gupta@oss.qualcomm.com>
 <8dc8c094-63ab-4f9c-867a-96b615dff2cf@gmail.com>
 <90c2f6d5-21cd-4ba1-86e4-458100c8f830@oss.qualcomm.com>
In-Reply-To: <90c2f6d5-21cd-4ba1-86e4-458100c8f830@oss.qualcomm.com>

--------------q7nzm1aCz6wjRQL5UEw8NoVY
Content-Type: multipart/mixed; boundary="------------0hdEhfg1Mjy6CiCPDwuTIK8u"

--------------0hdEhfg1Mjy6CiCPDwuTIK8u
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2026-04-16 09:58, Ekansh Gupta wrote:
> On 16-04-2026 13:47, Luben Tuikov wrote:
>> Hi Ekansh,
>>
>> Good work. A couple of notes below:
--cut--->>> +static inline int fastrpc_wait_for_response(struct fastrpc_i=
nvoke_ctx *ctx,
>>> +					    u32 kernel)
>>
>> What is "kernel" and why is it a u32 when it is used as a "bool"? Perh=
aps a better name can be had?
> This reflects kernel message. As of now, just propagated the same that
> is used across the driver, maybe can address this as a separate patch.

I can see that its origin is internal to the driver, as a boolean. Perhap=
s "kernel_message" or "kmessage" or something descriptive like that. I th=
ink it's more important that it is a "message", rather than "kernel messa=
ge".

Yes, a separate patch indeed makes sense for this.

--cut--->>> +static int fastrpc_wait_for_completion(struct fastrpc_invoke=
_ctx *ctx,
>>> +				       u32 kernel)
>>> +{
>>> +	int err;
>>> +
>>> +	do {
>>> +		if (ctx->is_polled) {
>>> +			err =3D poll_for_remote_response(ctx);
>>> +			/* If polling timed out, move to normal response mode */
>>> +			if (err)
>>> +				ctx->is_polled =3D false;
>>> +		} else {
>>> +			err =3D fastrpc_wait_for_response(ctx, kernel);
>>> +			if (err)
>>> +				return err;
>>> +		}
>>> +	} while (!ctx->is_work_done);
>>
>> Perhaps you want to also check "err" here to make the exit condition m=
ore explicit. (The invariant in do-while loops is generally directly dete=
rmined by something within the loop and generally not implicit.)
> The reason to not keep "err" check is because the call should fallback
> to normal response(fastrpc_wait_for_response()) in case
> poll_for_remote_response() fails.
>>
>> Is it possible that in poll_for_remote_response() you get 0 as a poll =
result and val is not equal to FASTRCPC_POLL_RESPONSE? In such a case, th=
is may hang. (Is a hang desired here?)
> That's actually a good point, let me try making it more robust, this
> condition might get encountered in case normal response is sent instead=

> of poll memory update.

Right. We want to avoid this dependency. If the device hangs for whatever=
 reason (defective device, cosmic ray, etc.) this should not result in a =
process or a kernel execution context hanging.

>> Is it possible that if polling is enabled, then you want to poll only =
once, and if unsuccessful, or successful but "!work_done", then transitio=
n to fastrpc_wait_for_response() and return, without looping? (since poll=
ing is looping after all...)
> This is correct, the intention is the poll until it returns, continue i=
f
> successful and fallback to normal response if unsuccessful.

Right. So this was obvious by reading the contents of the do-while loop. =
If you prefer, you can remove the do-while loop, or at least take out the=
 poll_for_remote_response() out, and only leave the fastrpc_wait_for_resp=
onse() inside the loop, and decide how many time intervals you want to wa=
it. If that is once, then you don't need the do-while loop. (Effectively,=
 you've waited once in the poll and 2nd time in the fast_wait_for_respons=
e().)

We just want to avoid hangs.

> Thanks, Luben, for taking the time to review this change and for
> providing insightful comments.

Yes, no problem. Good work and thank you for your work and contribution!
> [1]
> https://lore.kernel.org/all/wipphezpxtuuxtwhpwamsmvhwgwuesexmy5ev5pcqb6=
5vov5kz@vuzzyyqnu7ci/
Ah, thank you for this reference.
--=20
Regards,
Luben
--------------0hdEhfg1Mjy6CiCPDwuTIK8u
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

--------------0hdEhfg1Mjy6CiCPDwuTIK8u--

--------------q7nzm1aCz6wjRQL5UEw8NoVY--

--------------u6hXa02bmrzTrAKCf5rbNvPB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCaeGu6gUDAAAAAAAKCRBMFUeUMaM0r8Uw
AQCj0T0Np+w+vi9aTASsrtwXtdly3Jx3m+hcYafBMLCqjwD/cgjN4ZlugPcnrjYw28n1jlreTfj7
JnhDdObDz82HrQI=
=iqZA
-----END PGP SIGNATURE-----

--------------u6hXa02bmrzTrAKCf5rbNvPB--
