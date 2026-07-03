Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C17CC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C732D10E60B;
	Fri,  3 Jul 2026 13:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WjRsnbQE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+RHAWfe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EE010E5FA
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 13:55:24 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663Br4Sw4091453
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 13:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=A2ITQjqnGvmrPumq1Lg0UMR0
 KWK9aB/bRTHDo6yM0WA=; b=WjRsnbQEoSG7b92R0ZHl5mxPd1UIQKYnvZMVzomx
 MzHsDMeryy5x6TXfxX0Tv8dq//hHUNGrc2b9/t9ZHQpa0LFvZu7Es/oKlZGSXnvL
 ZDXje4lzvun+y49QVm6VJXIyqpDUe+cez/zFSYIE0F3EYFFXCBhmsFuJFzFv+i4o
 n427a128BNFRHaYQevpHlf2skfYMLhKdi9gWmNClTd1WRlU4f8HpbPYwVbNG1jvE
 BEKoq4hV8T/gHHQ5Znz7eMQpMEXm9rGhJgjDF4EMmiWxUxn7EwvQvl6oRfns81kA
 OPuzlDpG6yJiqKh38J3u4O/RtD1gl4+of15QEPjoV4sj2w==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj0dec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:55:23 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5954c5fbcc7so465520e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 06:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783086923; x=1783691723;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=A2ITQjqnGvmrPumq1Lg0UMR0KWK9aB/bRTHDo6yM0WA=;
 b=W+RHAWfep5poUcSILC+UVkG8pG2aJvEO1/J4qA+EEvft2ZxL1BSOd8VO+Db7Mlb9eG
 8ZORzMMMaVJOKDhUhQ+zqwcq8RILWnttf4iEx7Uf0naq2eAlbl3F7kmaGzlDtQES8P4C
 hgTF23yIkWKdv+7t2yOWC7GcAhO3f/0uog+xyenvpo64+PIGgCDAJ7O/2Z0q54tBoHVg
 hp58QhUA7kesx5ka4chmelhE6lACoaHcWAt1eETfurQTohnqNQSLHQzMoy4JRDJI/6Rx
 ZCUNuKNFKRM1D5nrwx5KhgvT5LAfYYRzJbcYSCTq2fUwLt3rVneCTB7MT3CGtDhZ6wgy
 OmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783086923; x=1783691723;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2ITQjqnGvmrPumq1Lg0UMR0KWK9aB/bRTHDo6yM0WA=;
 b=RsUTcZ+kRo6rKyntBO+2rk0Nn4GBt/XvvSJ6M2hSKOp3cA2I33zAaWNnnrbjf7KAMx
 oBc0c0d6XX+Up9cELzcA1mfhtg1bq1ouTo08vrEy6zHazBTr9Vn95+xS+4Z/Y5kCDYBI
 b0f+1CRnr+Qtw5CVz0Jz2dkuiN6MYKSLuWwiP8Rj2Sh0gNqF7ayE/VscAfj0/2hrnDkg
 jCCMWSUxvL1vSjcambeLiRqakFMfde+m76OWkuKiO0Z5Evi7JTYYB6F2I4dgyVcFBK/V
 NuoObZpvf4aN5xwYLox2Ek99xiuKhkk2oe4XitvqRSA8MTeVc51ruoZxef3l+LnwH6Uy
 C7lw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqV8ai4nbUAZ93fdEQt4E0IU1+0/cvY6jZuoEmYjbnN2B/REL5kWv7bx8+218rxRxlzzQuROMXOqYA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfiW4gLEuSasRwA/WyGu1bwyiSZbzWoCND6ncqzFsvDLmGfgt+
 xeQbO1bwiHzD6rS+rQDb+gERw2JreINodEvn0/kpkU1i5HPFrjiDCJm21l+c7ggibBH1MmAp8X8
 e5FxsDURIm8FNUzMZWzPTF6kRtvnxrj+Ol49XzzcVX+QuPMy1RNMhoBtgi6YF0gCO3bKIzCQ=
X-Gm-Gg: AfdE7cnmEfzPhi3CeiAElLb4eyPUpzKJkoUrwSEmC53Dim+bAqkKpwWMkYXInDIXVnR
 UHr4CW9ymSiiaJY0pZ28Z2gSmPVkcHI/e3s+rHzG5DnVVn47HHqFGGIVRU0jg+UTUu+vd9hG8yn
 lyrm7++BHzPw7tP5qGykThSR2D8wh0HB/S1nejSo+RLbecY989EoOG/AsbbZsctZrxQNZZvdJz2
 34lHyqn8kgY8+uDYwJ/vWqwj7Go9eXeSPxRb9ziRAfhqNWmGiTZxPJq0XKtRVQ9kXHml0/SmvhQ
 E15nYiJ5Kh/3idntFjPP+0cfSmkQ7tYo1ZHqvtqVbFiC2wYr+d33HWQG4are4roLPQRi6s199Kb
 Mhk3jrZVCmKiCk/Be/ReVTp5Gd0LYP9H1C/wpAcYjp19y2DA9xKi5sh1su+TA8PM2pVQo0vppnv
 h0AKOoB5rg2i1pQrGldwrpkPRC
X-Received: by 2002:a05:6122:1785:b0:5a2:5669:d6d7 with SMTP id
 71dfb90a1353d-5bddf66e951mr3967959e0c.9.1783086923020; 
 Fri, 03 Jul 2026 06:55:23 -0700 (PDT)
X-Received: by 2002:a05:6122:1785:b0:5a2:5669:d6d7 with SMTP id
 71dfb90a1353d-5bddf66e951mr3967937e0c.9.1783086922479; 
 Fri, 03 Jul 2026 06:55:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13bfde7sm487894e87.56.2026.07.03.06.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 06:55:21 -0700 (PDT)
Date: Fri, 3 Jul 2026 16:55:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v8 01/39] video/hdmi: Introduce HDMI version enum
Message-ID: <vnledtvhanfj7owf6wbu35up55jv7vsb5qvd5vmv6cgzfo4pox@dbvfatear4vx>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-1-d79890d00b6a@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-1-d79890d00b6a@collabora.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXyE4/Rb0+TiTp
 em0HrIhDSjKzAsKQceQWry5QKiSYq3/ZDgP7h/uZ6z4TNim10N6YbiGig8MyrAVeqDTK0iecsky
 5rFbl9Q/5UiiLtB+h//FqvhCgtcGPos=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47bf4b cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=VFBjkeCnKAITTyYkkK0A:9 a=CjuIK1q_8ugA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: YMHnFDRI3vNoel-RdZkqLJBuUSqRYG8n
X-Proofpoint-GUID: YMHnFDRI3vNoel-RdZkqLJBuUSqRYG8n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX6TzayMWZY58+
 0IHJtnFfqm+Qwtohfl/hNFjQi2hMVWZc1aWuwuw0E9UqwEPdCKjsewglP0EVH3tnRLjzIrkQsTF
 1WLgP1C1K5W/RMjw0ZohmwF/3qsd3JmEoVy8JQGwhcyUTL2cfzKbyw8ikiBO/QRLEpUR3pFk/LO
 Q+lGFA6G6tWqkbEKgJoNfZnajbc6dfWKt5ufGdNukKXJEjSMxxZ2EY5+9HY/ydKOEYBOoWO4aht
 vebEo3Pd31p+tHz8N9j+eeFK3dab3ZzNw6HkBirzziHE0MQlqkTPHNi2kB5w2XDR3Im5OwbdiRg
 YGphBvtdtUeGhfIoevCtMFiPrBsM9qiQdVqUlRFm8FJ+NUyNRBlPAy6ffhG2RiIemI/F2Myryxy
 RB56GKGO19EcaDvPSbO1Fck9kGgr6xWUDrBGu0v5s5oGYs49ueE3n3t8XQ41bcCMjYUzXSC9z9Y
 VElvjwKQNOfqzNY5/qw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030137
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

On Thu, Jul 02, 2026 at 05:46:14PM +0300, Cristian Ciocaltea wrote:
> Add an enum to represent HDMI specification versions.  This will be used
> by upcoming changes to associate HDMI connectors and bridges with a
> maximum supported version and to simplify handling of version-dependent
> features.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  include/linux/hdmi.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
