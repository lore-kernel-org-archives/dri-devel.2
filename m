Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCF0F8A140
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5315E10E840;
	Thu, 16 Apr 2026 08:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eQaJVSoS";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9EF510E840
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 08:17:53 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8cfc2d1fdbfso581712985a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776327472; x=1776932272; darn=lists.freedesktop.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u2ZjfbInVFTY5PYo7jzcdvXUYZGYONUg3u6BG3gcFj4=;
 b=eQaJVSoSNET41CSbQ4fNcA4/uH1DlGNahWE/Qeve5KDhV6nVEzwZ6oz27K43zsa0bF
 +B2OSbgUijtqHJAzQawHEPdNsaGDd6A3gTeugqbNcw/FPKbWxYCpzMhgGaosgN1F7To5
 cv3hy7XBld8KtXsRfekd4SBaSJPFiwqNRQVyPWICAucVVm/rk90nfOAEkDV0CnsYLhES
 MsKTypLrzqa/uEPoD6P8qMjCgxzIDnhddAuVdG9Lpwe8L4DDVx3vm00f8DCO1gpnLiwl
 JoeK77E94efYAcVCjE1HrbtUYsN/H1k9hctkDpywD5rPctjsAGHen6FwWFG2AZWGrZRp
 99Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776327472; x=1776932272;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u2ZjfbInVFTY5PYo7jzcdvXUYZGYONUg3u6BG3gcFj4=;
 b=tEu4pi1qSnoUCAvDQBbP03uMt0c1bdV7fL4b51Dhtg+5qk6rFR1eRv8XK5JmKZtbm2
 ZIugsZFgvK7wC6K/CptH2dfUgOuat40x2CU0q25kg8WIchvR3uenjoTGbWAoiDDHtldW
 LgGaIW2Eg9ZayvbhMql6Oaj9rCQ2VDvrN7dFkZtx0ODMCZuAFayHxIPsvPrJVcovNktc
 0o0TcUs6hB05a168p0LBBKialaxlzB9BsgGAS4HLp45A9wcuPpluL8ZXOD30CtDkhjNV
 bAI3UyYwxeNhONMxjDt27jJywahdNNaq6vMTDQXF3MnyoyJyK0mIs9fT2fRGjEnf6a4r
 sCeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8YennYoqlTRBYg67y6RZ+mk5WwfaYIzQc2u/ZERZtnSXDn6dqxUayEMrtETjx6eeZqFwMcHmoa0O0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxnz1P0tLcFR82KWFEnuK6zpSD9YT5fshLohfdvYvs/7gzMzoVW
 rjV4n7MO7yqj128MWl74wG8k11U6D/zNxs8N/KiKKOireeMjJo8XVowk
X-Gm-Gg: AeBDieszApNsK8w8CVuEup8CAssFcWVrNC9P/6NB8svY6VEvrYO9uU2Q1cIVNpYFEWL
 +UU9HAagYstTPPc0sAZvdqcMYyOz6iQ+hCmMDnLF9XUIU9PT/Tmt4EDyYWXZs1dRdN6wfm0pl9T
 VCloSJtMR5Q+hIAqrSgX8C+OsKJIoPyiuKGUtHenXiqJHNEqt6v32mZ2wqUshZkRO0srU7Z15DA
 Nd6oDNuI73NibpY80UJMlx4tSOvzXkj/PoFT/4FDLWLWJfjBeh7Dwwqtg4JrZIeNAftXbeWmk8L
 7L1CfpRySuSko+AQNblPWmRzj6jHZIFksILNvIsKsIaKZvJ4q7iKRIWZUVAWGPDxzsRPs2HQgVT
 QRmBvqRpD34JK4e2BxX2nQS6aZrSFbqqMLeLdxLOriP6HXMOVdiV4Hejsq4gl/X8UIZyTlfRVA6
 govzmjeOEpiTo1JHZJL5Mj+TAp0yK6pznQVpqiDg==
X-Received: by 2002:a05:620a:d8a:b0:8d6:874c:a762 with SMTP id
 af79cd13be357-8ddd03973ffmr3928880885a.54.1776327472259; 
 Thu, 16 Apr 2026 01:17:52 -0700 (PDT)
Received: from [192.168.2.25] ([184.146.175.99])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4ef33afd3sm312406885a.17.2026.04.16.01.17.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 01:17:51 -0700 (PDT)
Message-ID: <8dc8c094-63ab-4f9c-867a-96b615dff2cf@gmail.com>
Date: Thu, 16 Apr 2026 04:17:40 -0400
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
In-Reply-To: <20260415112530.4083240-5-ekansh.gupta@oss.qualcomm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xN0t5LhGw6YuTD2O0ja123f4"
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
--------------xN0t5LhGw6YuTD2O0ja123f4
Content-Type: multipart/mixed; boundary="------------AQKjfm64Py2xRSpCXKO1GqWn";
 protected-headers="v1"
From: Luben Tuikov <ltuikov89@gmail.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, srini@kernel.org,
 linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 andersson@kernel.org
Message-ID: <8dc8c094-63ab-4f9c-867a-96b615dff2cf@gmail.com>
Subject: Re: [PATCH v8 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
References: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
 <20260415112530.4083240-5-ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260415112530.4083240-5-ekansh.gupta@oss.qualcomm.com>

--------------AQKjfm64Py2xRSpCXKO1GqWn
Content-Type: multipart/mixed; boundary="------------S05zGcNgK51jtBwXIQA5K08D"

--------------S05zGcNgK51jtBwXIQA5K08D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ekansh,

Good work. A couple of notes below:

On 2026-04-15 07:25, Ekansh Gupta wrote:
> For any remote call to DSP, after sending an invocation message,
> fastRPC driver waits for glink response and during this time the
> CPU can go into low power modes. This adds latency to overall fastrpc
> call as CPU wakeup and scheduling latencies are included. Add polling
> mode support with which fastRPC driver will poll continuously on a
> memory after sending a message to remote subsystem which will eliminate=

> CPU wakeup and scheduling latencies and reduce fastRPC overhead. In cas=
e
> poll timeout happens, the call will fallback to normal RPC mode.  Poll
> mode can be enabled by user by using FASTRPC_IOCTL_SET_OPTION ioctl
> request with FASTRPC_POLL_MODE request id.
>=20
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c      | 137 ++++++++++++++++++++++++++++++++++--=

>  include/uapi/misc/fastrpc.h |  25 +++++++
>  2 files changed, 155 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index c4a3547a5c7f..5311a4ba4bb7 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -24,6 +24,8 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/bits.h>
>  #include <linux/bitops.h>
> +#include <linux/compiler.h>
> +#include <linux/iopoll.h>
> =20
>  #define ADSP_DOMAIN_ID (0)
>  #define MDSP_DOMAIN_ID (1)
> @@ -38,6 +40,12 @@
>  #define FASTRPC_CTX_MAX (256)
>  #define FASTRPC_INIT_HANDLE	1
>  #define FASTRPC_DSP_UTILITIES_HANDLE	2
> +/*
> + * Maximum handle value for static handles.
> + * Static handles are pre-defined, fixed numeric values statically ass=
igned
> + * in the IDL file or FastRPC framework.
> + */
> +#define FASTRPC_MAX_STATIC_HANDLE (20)
>  #define FASTRPC_CTXID_MASK GENMASK(15, 8)
>  #define INIT_FILELEN_MAX (2 * 1024 * 1024)
>  #define INIT_FILE_NAMELEN_MAX (128)
> @@ -106,6 +114,12 @@
> =20
>  #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, m=
iscdev)
> =20
> +/* Poll response number from remote processor for call completion */
> +#define FASTRPC_POLL_RESPONSE (0xdecaf)
> +
> +/* Polling mode timeout limit */
> +#define FASTRPC_POLL_MAX_TIMEOUT_US (10000)
> +
>  struct fastrpc_phy_page {
>  	dma_addr_t addr;	/* dma address */
>  	u64 size;		/* size of contiguous region */
> @@ -236,8 +250,14 @@ struct fastrpc_invoke_ctx {
>  	u32 sc;
>  	u64 *fdlist;
>  	u32 *crc;
> +	/* Poll memory that DSP updates */
> +	u32 *poll;

Perhaps "poll_addr"? "poll" seems just too generic.

>  	u64 ctxid;
>  	u64 msg_sz;
> +	/* work done status flag */
> +	bool is_work_done;
> +	/* process updates poll memory instead of glink response */
> +	bool is_polled;
>  	struct kref refcount;
>  	struct list_head node; /* list of ctxs */
>  	struct completion work;
> @@ -308,6 +328,8 @@ struct fastrpc_user {
>  	int client_id;
>  	int pd;
>  	bool is_secure_dev;
> +	/* Flags poll mode state */
> +	bool poll_mode;
>  	/* Lock for lists */
>  	spinlock_t lock;
>  	/* lock for allocations */
> @@ -923,7 +945,8 @@ static int fastrpc_get_meta_size(struct fastrpc_inv=
oke_ctx *ctx)
>  		sizeof(struct fastrpc_invoke_buf) +
>  		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
>  		sizeof(u64) * FASTRPC_MAX_FDLIST +
> -		sizeof(u32) * FASTRPC_MAX_CRCLIST;
> +		sizeof(u32) * FASTRPC_MAX_CRCLIST +
> +		sizeof(u32);
> =20
>  	return size;
>  }
> @@ -1019,6 +1042,9 @@ static int fastrpc_get_args(u32 kernel, struct fa=
strpc_invoke_ctx *ctx)
>  	list =3D fastrpc_invoke_buf_start(rpra, ctx->nscalars);
>  	pages =3D fastrpc_phy_page_start(list, ctx->nscalars);
>  	ctx->fdlist =3D (u64 *)(pages + ctx->nscalars);
> +	ctx->poll =3D (u32 *)((uintptr_t)ctx->fdlist + sizeof(u64) * FASTRPC_=
MAX_FDLIST +
> +			     sizeof(u32) * FASTRPC_MAX_CRCLIST);
> +
>  	args =3D (uintptr_t)ctx->buf->virt + metalen;
>  	rlen =3D pkt_size - metalen;
>  	ctx->rpra =3D rpra;
> @@ -1188,6 +1214,74 @@ static int fastrpc_invoke_send(struct fastrpc_se=
ssion_ctx *sctx,
> =20
>  }
> =20
> +static inline u32 fastrpc_poll_op(void *p)
> +{
> +	struct fastrpc_invoke_ctx *ctx =3D p;
> +
> +	dma_rmb();
> +	return READ_ONCE(*ctx->poll);

I think you're better off using readl() here, but see my comment below, w=
hich obviates this function.

> +}
> +
> +static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * Poll until DSP writes FASTRPC_POLL_RESPONSE into *ctx->poll
> +	 * or until another path marks the work done.
> +	 */
> +	ret =3D read_poll_timeout_atomic(fastrpc_poll_op, val,
> +				       (val =3D=3D FASTRPC_POLL_RESPONSE) || ctx->is_work_done, 1,=

> +				       FASTRPC_POLL_MAX_TIMEOUT_US, false, ctx);

Is there any reason you're not using readl_poll_timeout_atomic() as docum=
ented in linux/iopoll.h?
Does readl() not satisfy the read operation in fastrpc_poll_op()?

How can ctx->is_work_done be updated here? Perhaps you just want to use "=
val =3D=3D FASTRPC_POLL_RESPONSE" as a condition here...

> +
> +	if (!ret && val =3D=3D FASTRPC_POLL_RESPONSE) {
> +		ctx->is_work_done =3D true;
> +		ctx->retval =3D 0;
> +	}
> +
> +	if (ret =3D=3D -ETIMEDOUT)
> +		ret =3D -EIO;
> +
> +	return ret;
> +}
> +
> +static inline int fastrpc_wait_for_response(struct fastrpc_invoke_ctx =
*ctx,
> +					    u32 kernel)

What is "kernel" and why is it a u32 when it is used as a "bool"? Perhaps=
 a better name can be had?

> +{
> +	int err =3D 0;
> +
> +	if (kernel) {
> +		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
> +			err =3D -ETIMEDOUT;
> +	} else {
> +		err =3D wait_for_completion_interruptible(&ctx->work);
> +	}
> +
> +	return err;
> +}
> +
> +static int fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,=

> +				       u32 kernel)
> +{
> +	int err;
> +
> +	do {
> +		if (ctx->is_polled) {
> +			err =3D poll_for_remote_response(ctx);
> +			/* If polling timed out, move to normal response mode */
> +			if (err)
> +				ctx->is_polled =3D false;
> +		} else {
> +			err =3D fastrpc_wait_for_response(ctx, kernel);
> +			if (err)
> +				return err;
> +		}
> +	} while (!ctx->is_work_done);

Perhaps you want to also check "err" here to make the exit condition more=
 explicit. (The invariant in do-while loops is generally directly determi=
ned by something within the loop and generally not implicit.)

Is it possible that in poll_for_remote_response() you get 0 as a poll res=
ult and val is not equal to FASTRCPC_POLL_RESPONSE? In such a case, this =
may hang. (Is a hang desired here?)

Is it possible that if polling is enabled, then you want to poll only onc=
e, and if unsuccessful, or successful but "!work_done", then transition t=
o fastrpc_wait_for_response() and return, without looping? (since polling=
 is looping after all...)

> +
> +	return 0;

"err" is always initialized so you can return "err" here if you exit with=
 "err" as part of the exit condition. (And if you add "!err &&" in the lo=
op invariant, then you don't need (if (err) return err;) after "fastrpc_w=
ait_for_response()").

--=20
Regards,
Luben
--------------S05zGcNgK51jtBwXIQA5K08D
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

--------------S05zGcNgK51jtBwXIQA5K08D--

--------------AQKjfm64Py2xRSpCXKO1GqWn--

--------------xN0t5LhGw6YuTD2O0ja123f4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSZI+/lZhTvW3mgJddMFUeUMaM0rwUCaeCbJAUDAAAAAAAKCRBMFUeUMaM0r8Vo
AP9WJmN4Q2hEUkOxLBryVAF2pXe//FmJ8gPI7CjyCV15BAEAgSG5h3/wdSlwchwof952csqUEnNy
zRf038thQ2HcUQw=
=tPQ1
-----END PGP SIGNATURE-----

--------------xN0t5LhGw6YuTD2O0ja123f4--
