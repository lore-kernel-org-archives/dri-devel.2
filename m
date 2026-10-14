Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BC6CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D77C410E16B;
	Wed, 14 Oct 2026 18:27:01 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6B010E16B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:26:50 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EFpkFt1672554
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0kUHDWUO4or/+EF17+1xTRR1
 jpLQfX+2UGgESCKn/gg=; b=S9e/KIGfGeERp9UddwFCfVIJWpgtKMOdl8czRRA5
 DvCsi47rgH2pNno9dqZvhRyi6H7ayv5HMA8RMRQ5aI+5Ckj3KrLOw0bKsZpLNef1
 3fZ2Vo1OWrY8M6Px1mwc+RVMMVdlaKXVzDwOfppB5gdK6bVngkIxhWbYfYwSuHu+
 XTOPMjXry9IJrIRiFp5X5Bwd/JpUKhGl+c+pKremhu8+1qmK+jeqQ2VawmlwFX5Y
 vtXIZWsO9O3Bix21+UpZN+cviUFQP8RvNCOkPPwNko6aWFnUGPp73FB4LIZxeBzC
 meTWqQVS/pSQn00wNzZsgoWH1MXrFYbNdTIxnasg5mFRAg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacrh8m5a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 18:26:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso91827385a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002409; x=1792607209;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0kUHDWUO4or/+EF17+1xTRR1jpLQfX+2UGgESCKn/gg=;
 b=Mq32ffJ+8diSL51BPro4fXCFRXGcPNtYBtTQqQLUiy3jkjf/0ydP7m8sl2jfCtDAZP
 phX/oQUAeTD3JRccihcBkqPlTvtTVU4rlCq9eJzi85ydNAzaqSffG8jC41Wt3968gPfL
 3D0pxdKIEsX/p3/JKGmkqabI3DN0qJD4CafsdO7S889U4gxled6XeSCnJ2MAmE3dgYDH
 I0+IZKCMU1qI6xp9Rh5L/5zHLkqgHvCRbRPcgc8UmwTebPvKmcJhcU/RbaoPkeLcdFeN
 PwyVLp5RtWKLU+i5M1YXQeZ43fRvyW2EQ/wBOO/u2Kw6ir1pwZsmWLsssyxLjI++IW9W
 kaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002409; x=1792607209;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0kUHDWUO4or/+EF17+1xTRR1jpLQfX+2UGgESCKn/gg=;
 b=avr61Sqtr6cB+86EIm6wv8wx80I0LiFvpDfszMDI7aXMIz8/qlkuuOMRE5VOjNuIiy
 FExVNyoMkPOryYNjVX4MSOP0bjHkgySYnC3mI+WVNxmV4jj7NtVrFFBQQtylWt6HDxUY
 Fy2wawqhFsxn5G4HqZBPqmtv6r7YVRt8AsQFf4tZ3KxJAYYUgrBIWz614c/CS7MBJ3lE
 fXhI+ylJz/768Jq5MQPaefHZlYg6F3VLbYDNi0H1BV1V3IZ+VN/834WvX5AUFcNDh0jP
 0y/6aMRBCE5pZZQv/ueNrrdPf8bHaC8RPQv8D8oapwLjxYekX8B47l7TkWkAeiiwANFw
 SDZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6yJk2DSUw+W1ghv7Z9kTOl7tfIQ4VBjqQSX3WGlnxGGMLrfqHBvVndmdjHJveqhpWSjiOZspNeDQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIBMKUlK8BjSvZ3qQladC+qUZIaWTVj2PeUqA10YD+Cjt6g6xph
 wExCGw5XIdAJF1vVnFn8lz7AFV6Jw/Nk96ch1ebR/xcR/S09rKrWlqHKb72e+cFm3cCeWjZPo1a
 xQcC0z+Rg+5eSf3KrAFVz+948YxrA6vpl2rw+fCxJB+2Xb2JWoAtyX07McNvDN4zKEmNtrlY=
X-Gm-Gg: AYBFou0oVvOP9S8jdwZu9O4EZKLQPBp0HIm1NfFOmUUnyw0jpocZ2bmjqg2KxmNw2QB
 8kC+LghBHiPT8t5/laegjXka0qbzWCqRXKi2mUUCLK9iA4VYppS8+1g/OV+2ShGQ0jxXjredTOk
 T85QMws2M0C2iV5kuh1Jej8GdN+PZ88b/zgP+06oSM4gFTgwI8Bwd/GdEROZT2gK/jaXcLjl/ll
 ij7quqP6eZ3MtssoMCaKdayyi0g0OM/dVBl5Cf6nsFrBxF4Ufl3E/n5dEH9ed1QKvOc9emG0j2j
 G5G6kYH5Qlv+h/GspfIKIDuKG3w9IQWWxfghtoHTT+JUaab7GRbpp7fsqR6hZvkPZPM8vIZWlPb
 XrIpq5BBFKMmhbZK1vikxCl0seyTpKEo92yOmsFNUd3jLyMnpdqbdVp9cRrgyz9MAlu0NQNOnxa
 cUh1gEJOyRUuGA
X-Received: by 2002:a05:620a:3947:b0:93c:c08f:ecf with SMTP id
 af79cd13be357-93ebd278733mr2935893985a.53.1792002409039; 
 Wed, 14 Oct 2026 11:26:49 -0700 (PDT)
X-Received: by 2002:a05:620a:3947:b0:93c:c08f:ecf with SMTP id
 af79cd13be357-93ebd278733mr2935890285a.53.1792002408552; 
 Wed, 14 Oct 2026 11:26:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafdeab076sm970951fa.12.2026.10.14.11.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:26:47 -0700 (PDT)
Date: Wed, 14 Oct 2026 21:26:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 15/75] drm/bridge: sii902x: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <7vnivd4qgpc5ezqmhccbvgxosyup3vo4r32ntke2vrrdhhbjsu@jeuixjoerjin>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-15-586c9c026823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-15-586c9c026823@kernel.org>
X-Proofpoint-ORIG-GUID: 0Hbw20m472bgYG_Qevdv4xK_o4535RT2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX2LD2BFuHuV9c
 xWunB5bdmafD6U9UUzGD8IMwXuxw/eHkffSNTyxhvvtaIDb3GJoLLjoMP7SiYtE0VPoe8QUcCWo
 7zxEb+43RO3MaZpbnf4c0+8NvuCM/F0=
X-Proofpoint-GUID: 0Hbw20m472bgYG_Qevdv4xK_o4535RT2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX/2ntoB/IxECi
 khoyPQBki+4J3PtWTdhIwpbzYy7MQNevI3bP5D1zjGETQuoGl7maQxDiJ/u/6SXFcBn2ZEVRmhF
 UKfeogUWAZYL1zy4/Nd/urfVqrnsyh5yoaDtFIqBAwZ8+MfoRlITD/Hz2jIGD9UMlsEZcehcmwZ
 Cu7dx1qgWcC6Yg6H3bRKTq6xCe/2DEUZ0kii71P+Tf0+UbOHwj0TjpEqKHIOn5nqJaeNUxS5WeA
 HYrBHO45Gv5TIPY5AqJKNR+gafDT8yldgJWfnqDHI/HkxRSrlzo670ciRze63Hf8UKEP/fOGiOh
 XfbEpk7jX1gc7a5lQJyfTXnkAwvJnvnIryUHPR0giNZVzo5iv5/O33KQjdkdsVnTJwFHwhcRZxF
 +7dlJwoXG/kJrBXXMzBnYXzPbiuS/GCip7gYipwv46GJDXeFo6v5j+csRfmSK5c5G/O9tSAV34n
 rClVconEVLYmtMeMr5g==
X-Authority-Analysis: v=2.4 cv=SYZi5fRu c=1 sm=1 tr=0 ts=6acfc96a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5SmR4ZfugbDr7p1Jwc4A:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140073
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

On Wed, Oct 14, 2026 at 07:26:38PM +0200, Maxime Ripard wrote:
> The bridge: sii902x connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_connector_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/bridge/sii902x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
