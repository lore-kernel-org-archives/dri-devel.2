Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1ADCD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A2310ED5A;
	Mon,  8 Jun 2026 06:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5QrppdW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iyhf640J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0499310ED5A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 06:12:16 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6580EAsG1469249
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 06:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=WVKWxZsnq6xE/GGUlxylGRbf
 kAGhFykn+8ukYkAUUnY=; b=a5QrppdWR8HfJPGIoCxldQjiWTwa/DbcP8h0DViO
 mOCw3RXN0L9ivo59eUzgfT84IpOVdfVgdhEIUgmHF5dOqRI81ULKcvn3ZPGD80My
 ZgC1Gfm+2Ex50TGgTAb7AIMo2B1FWU0P0jQQBYJq0kv+dOn/FKXKjryvj1locdHe
 p/e88rUQKs1x4zf1zpVF+E5EVAzKjyEEDVBeq6MDAPB2m0N4o0zI9eXfc6ogaPRe
 jHU/3gfCEhq9XzgTfT1uSSBSwPvEztSL19Q9IrA7ewDyB7Z6iHuipxK9qLeGwbdX
 X5C2LrcWuWXDQ6t1ISoUBxjNXPLitB8FFEbGg8drJYBXJQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgwx6r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 06:12:16 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccd5491db4so28989836d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 23:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780899135; x=1781503935;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WVKWxZsnq6xE/GGUlxylGRbfkAGhFykn+8ukYkAUUnY=;
 b=iyhf640Jiksi56T1OV1LWzYH1S5ycVNz0pQx9drO4oFmH4N7ACSYZ/Ghzw6CryngMU
 B3YKVdzuvgtJ4A/la10Ty931ezCEDsSJnzgDkOunXLQTaL/fPiZaV587O/6vjQXaIQrq
 MibErpJvfosnHiLqssRo4s0keDexwTDkny9GJYZ7vHsaFt3V4qiFUX5doc/dLV7gMxkO
 yepZ6FfqwaYV8/31kMm6Xh9RUy88SJ+D9erqJgqU1iUb95H0Lqu7kcIXC8NlPtZ0HqRL
 8B1/6op60CwTDrFIeY6yUzQftXB6HZ6POT9+79aNgTqbUYVVAYS1+pl0DcOuvnuYXYuS
 L+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780899135; x=1781503935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WVKWxZsnq6xE/GGUlxylGRbfkAGhFykn+8ukYkAUUnY=;
 b=N6+1KBD7WFl0TKwIzdwIQgyt/tX+4zo3Q/MC1F9eMBhpQ5OWDSf8B64IrU9hgRVMZh
 zMuTh3qM+PccvpEpF6RYw+jc3vt5MrzMqG56O6sBy3D7t0Xj4C1vqDcol2is8Q+ZAqZD
 Ky3qptkrUCKoOxxdR0Un+JT/g5rVC44VNNc5n+NXbDfzH1vrtNTWvaPxBKzph5yVxau8
 lNUN5Kk4tDKllC2p1r+e41wmWTVt46Wee1mZTRPc41r9wp3fgZlgxfoKMr4m+3VPP1sZ
 hXdHnevd7LWlz3ej9yJML/I+bk0WjvsQ26DbioERp3/GWYykvn9NpbHhrWI8FWZLe61p
 UdQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HuKjz+N1+bSoIeDMhIDBNnOUxszznKePgQ9S4N4GGZflRjqvnJaWd/bM9fu5/rP/jndY/v3VWRb0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfxqUFZQKxWnVlzzIpOQEjEdeQCIPx2wrXYMMMkTtsojmXh/u9
 kWaSPet6oRT+RTcm9cW+HuQEy3mearrVR1rx6Tl4oXiLgAt+BRWDBApkoMDhhAn4lTnW8vFGTKA
 nSsxQGG6x+0dbJwfKvvfZuAoMWEEXWNgFD06VLVMAnrb8ykgojQhUaE2A5NADJwozTc7v7cw=
X-Gm-Gg: Acq92OHm8D+IlCUjnrgKnD0PBoPqQPcsFwSa1sVgq7g+bSwRtWw7ocUhXwbwE+hfliF
 r6jhEPZ9XwglW8Z5EMPzcJWrJObMZJsTECK06aX4+lpE1UKhdnG2Xuu/qTEtO5HUELSj/SaeRJa
 UBJ1aFAnJxe/5OAb+zw9JbasYGBHusLtUUj+6tQnqvO/C69MGEyK3LzRk6mG5wsSWmwD0gFZ8GB
 LZwqnmjQ4rsXW1EbFuvwVpHOFkmrHqlaxE/ZrWeldhFOfWwfFZrGEqfy2aN+lDG+L4SRWo7Fb6O
 3EEXoGXolHA5l+qyS1lvIubivNReY/P1R8skJ+pdcqIVx/dCLhkYs2z/9j4axMQRVp8BeBJACTG
 Oykgtj4PHmjlTlHhanNOWxXXAQ2CpFI68Xdw+BhTg+YN+b/+9Sq35qDAxcnne3vjG6P9GJfubYG
 AvlOyFi/6DkaTNyiQntzPa1TTsw6mxKJIiPj8sme6aDG25ew==
X-Received: by 2002:a05:622a:1388:b0:516:e031:9343 with SMTP id
 d75a77b69052e-51795a829e6mr195423281cf.11.1780899135479; 
 Sun, 07 Jun 2026 23:12:15 -0700 (PDT)
X-Received: by 2002:a05:622a:1388:b0:516:e031:9343 with SMTP id
 d75a77b69052e-51795a829e6mr195423001cf.11.1780899135009; 
 Sun, 07 Jun 2026 23:12:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2be2absm43191071fa.23.2026.06.07.23.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 23:12:13 -0700 (PDT)
Date: Mon, 8 Jun 2026 09:12:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org
Subject: Re: [PATCH v4 6/8] drm/msm: dp: handle the IRQ_HPD events reported
 by USB-C
Message-ID: <w34p2gevaxzr7do4gxzgqbbrtadnemkzrafcuroeytd2dphrrh@qgw5ld4rpylf>
References: <20260608-hpd-irq-events-v4-6-30b62b335487@oss.qualcomm.com>
 <20260607214829.B05091F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607214829.B05091F00893@smtp.kernel.org>
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a265d40 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=vviSY2pRISl9Lsm2BZEA:9 a=CjuIK1q_8ugA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: H-ESVQst4PLKTIcb1hS-UhLUmcS43y-c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1NCBTYWx0ZWRfX9/ny+BZ0r59b
 Iky+S7UAa+Au4A3XMXMjR2V50vQK25lC5y1LrI5TcDtSxtA0Ix4q867/skm9rVKpQyfp1QMQ57o
 4HfBauG0MmEhtKsW82pf+w6xO8vcd2BGteGsYFQjcWQmI4RTYE0LZCcjLwkQHYLPC9IqKVPPrDp
 IHpvO45cylRmA9Ifv5zbuLzj5TUm8R7l4P+Cl5zBvBRiWLJ/278PWzOvEmV+asD2ODQ3O868nWk
 Kl69VSd1EMgrVbek4aJNsv8Jkd3btf4R/EP953gH0/QUwezoC91TldrcdLItxQcSLR2B9e3GqSa
 i0MRXKCgBsRQl4ftxFKZSPxpZIFH+Wergwk8xOvC+q1NEnZzlPNJTpu5ol42xnar+A9e6+emZcs
 x0hBtk7Cw0Rm+Wv8yA0jP5KpyEcb1uMaMevK+Jb5+8BF/YKR/iqJ4t+4dKIMaWnTbeKUHyNoRQu
 Y/GojKqdJ0ln3Pznaww==
X-Proofpoint-ORIG-GUID: H-ESVQst4PLKTIcb1hS-UhLUmcS43y-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080054
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

On Sun, Jun 07, 2026 at 09:48:29PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Initial connection and replug events are incorrectly bypassed if accompanied by an IRQ_HPD status, leaving the display disconnected.

Indeed. I'll fix it for the next revision.

-- 
With best wishes
Dmitry
