Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29311CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:43:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A9910E692;
	Mon, 12 Oct 2026 20:43:39 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2896810E289
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 20:43:33 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-486e8faff03so957445f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791837811; x=1792442611;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XK+SEB+e/GS3thSnPWg9ZaAuDfBuOx8piTMr3Esm78A=;
 b=V262Vk7HrkKv6D8bKF64pLrf6zBagoobIpbsG6zOn+/edMttT/CUqFk0MJ+qOf4eM1
 etaPDpk/qE3T43twJgDLwYlcw2pcZ3YdBkGvFdZgHLy1RcvQpcf4OSw8slhOUWAOL4ET
 AZpv3j789k01bvdAu5rhHVzRey55bt9IPjoANP0VS5urYUPsoIfyQN3QE5UmOxuMy64+
 y5vy2ImWPNxbxkqt5wwxAjLSg5+wXQAm906KyetNL6ECHQyxnlWj4iI4oH/Egbllo+dH
 yaZSSM64/rq2Fdtp9tKwixBjk8qmt0H25zeSeVisOozWJL2c5Jsp4P8uszsksUb7C92X
 0mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791837811; x=1792442611;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XK+SEB+e/GS3thSnPWg9ZaAuDfBuOx8piTMr3Esm78A=;
 b=E0rxrE/vS+l1quI21RiF1ArTF12U5IQmmuA9Kp20zSrLLfUiAIrgZzbxNFNAePosoP
 l4i6kyhCZlECuSCOaoVgQwxrGIkW9nbdjPMfsgjjpdSoFpG6UI5m5/EsW6t73Zhc1N3N
 m2ajbi6Tc/iI1bTLM28l8DW/KiHIqYamVlZezsZD//9q8kmW8jGCcxoB3WZn8oGkuG+2
 c8pVLtT5gV4lqMTspj+wFFj1Uf8j7kOfq7mIeQBuU4EsP5WAsKL8Rgom2SemlW/KPAy+
 gM2SM1YDKAKL+5j0PmSp7C+Zvt/zijK8IbwDCcROr757GHE3qAMykdsgzgE7ABP9YSi/
 Nwxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz54fyvHVic+tlMiPAQSfRHHF0BtjvphdxjPmves3/S/viLo9wdshp7+KTxzhykVXExOGlBjCIAHdg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIHwPKOailzoYxxsz18bs1NqQ8+D8YsYgWcqXAqp2YYpYQ8vuLq
 1DvoCySMEvcjd9MfN8XtbSnbhLq3cHA8E2QRUQlmlE4p7blIvYY8g+UXntwwdnPU518=
X-Gm-Gg: AYBFou3gbVEazDrQzlL1dIfIfGbDaA3vk6/Hzl5IVUMHmfv9xl+Fq5ATTpYHEvM0iCk
 TDUoJsQLj/Jk4vr0Q19lMJ4eyrecuuqMraCxxNQQ814CeKy7a/rC/vFZic3onoRPwblVrvvQYkk
 a6s8vL8aXLCfUqsPNVEqEV7bmWeFiRbT0lBY8HhXHXfY6cLW1+Fd0I9+QKnYATXa2w4A6nx/Yuf
 wO0+jq2dnkPgTGa/2DBoV4k5pp34uePmy3XBacTihJJunLcjmGwKPGOZJK43vvoLEKlyljj1epw
 JKdEO4r4L+VCo9Bau5kcNyNRa/yt8bsgdYmqTob91YbFgq99JphQZR9tKeWvKZNTppIkutBDb+b
 7z9C9/ilWSREulzJLU3U6wUfChP5cuXmU/BlHL/R/b0fqdRni6meNwaGpnTAuueVto3xfY5OTXf
 4BzahbCyHzm2XkCwpA5uwwRH3gaKlZYCKjxU9UMwxfm8HZ84lqiIRKe5gCasKgdw0+sYXffLjS0
 Zg=
X-Received: by 2002:a05:600c:548e:b0:49f:f9d1:e618 with SMTP id
 5b1f17b1804b1-4a18e4aa057mr205547665e9.17.1791837811442; 
 Mon, 12 Oct 2026 13:43:31 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4a199e5db12sm197660805e9.2.2026.10.12.13.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:43:30 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:43:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Kishore Batta <kishore.batta@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mhi@lists.linux.dev
Subject: Re: [PATCH v8 2/7] bus: mhi: Move Sahara protocol driver under MHI
 host client drivers
Message-ID: <as1F08YNeWz_1bre@monoceros>
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
 <20261012-sahara_protocol_new_v2-v8-2-e12939d229a1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k75v5fxmll73bi5h"
Content-Disposition: inline
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-2-e12939d229a1@oss.qualcomm.com>
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


--k75v5fxmll73bi5h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v8 2/7] bus: mhi: Move Sahara protocol driver under MHI
 host client drivers
MIME-Version: 1.0

On Mon, Oct 12, 2026 at 11:48:00PM +0530, Kishore Batta wrote:
>  #include <linux/devcoredump.h>
>  #include <linux/firmware.h>
>  #include <linux/limits.h>
>  #include <linux/mhi.h>
> +#include <linux/mod_devicetable.h>

Why? There isn't even a (new) usage of any *_device_id. There is a
mhi_device_id, please rely on linux/mhi.h to provide that. The main
effect of including linux/mod_devicetable.h is that the driver grows
many unneeded dependencies, so don't.

Best regards
Uwe

--k75v5fxmll73bi5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrNRm4ACgkQj4D7WH0S
/k4JaAf+LQbc81GUcwrqUE1hp5/ZCb05DUb37f03Yl819y3z00pXYZgwXJDUTd9T
GxJKc/iB9t1KKUv41uObbdOWw/pX8fpB4QMUgZQ1hlt7cRumJE11HOvk3ieg5WNf
pb4dIHEZGziIGLgCybUc7cofDnbPzwRnzZHOM7ngjQ1pg6U7wFlwInyjQD9mkett
cBtgIfwxlb61WfBOpmn2HajtmR/jVHmrj28oEqs6rJYH4yqR5eDpna/VhGCLfSV6
/AGqL77ZVNBz+bljTJO/GmIXlHHKNMQ9siCwfbX8dqLVG+HqxQB9+07RAtKA7t3q
ehCntiPriE7DoQa/XfRDpRlCwDiqzA==
=+TQr
-----END PGP SIGNATURE-----

--k75v5fxmll73bi5h--
