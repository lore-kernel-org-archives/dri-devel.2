Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D715C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D2210F350;
	Thu,  2 Jul 2026 12:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RivaN+R6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jNYlmtMu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C191610F34F
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:31:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6628BmE93009447
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Jul 2026 12:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=f+dyP/KejBAaN80AUuoYjKUW
 9BvdcKtcvdbJ90bFZOc=; b=RivaN+R61L7Li8hv2lio5WLDjAZPz1nFRNiAKMA4
 L73Y1/vxoR5jfsjGvAWDofGs8mOMGHpZcZQqTF2ZxNsJ3KQ3S1F7FWpaGm3hyhRv
 /UgV4e7uoMRsPq3nRNzytkLTMFsRSh5HVdqPv+pWkPks4t48v5xu6mahP22DN4Ir
 ERWjlhiEBnwGkXFqHHIj314skAUuMK4IgaMOMOUbS5GS4IWb2yAzsH+iYhH+BycG
 PD8+xs8/3pIRtWjv43Ch3B23KJ+n2uuHlaIM4A4s6Fi2B3QVOor7tZC3Ja8ArPOm
 meHim6VlFzpX79JwkMYcVCoa39ZRuB3b0ktXsPkuFS/Zdg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f579rv055-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 12:31:53 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-966a617821aso472166241.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782995513; x=1783600313;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f+dyP/KejBAaN80AUuoYjKUW9BvdcKtcvdbJ90bFZOc=;
 b=jNYlmtMuLcLcnudP8v90pAzEGmZIpFlwvmRPSf6bof/51A96VaTE58nE+BLgIhqb0+
 l3ecCdhPAX7k1O16F05hT41vpXhLupSj7cD7aCtvOxB9wgMAKPe13Kb59VTlRVjXFUhb
 eZ2Y0O7NAshbR8LzgoO8xee0qCir8qqYSCupM8u6gnyPG4dfFAT7S5VsXIDONPNDwqRQ
 urMwnno1ZOoz78OabEUm8buEn+9eIKCsEJfADdz6atuYiOkbwzH7qfPN7cRHbomgIIDf
 AFlxsPBhkb4TquKxT7pwHXVpnIhgXgpnONgsnXgp8HiKy8HIbXaKBOpqBw3Q75en7Kgy
 vPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995513; x=1783600313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+dyP/KejBAaN80AUuoYjKUW9BvdcKtcvdbJ90bFZOc=;
 b=KK90aAlnPxtw6sXzfq35GVpIcHP6zOrwn3e/5WWWhJVR+YmYlxUrlkl86Z0kdcu2C9
 QGsllzdqm34xwqnVxTESjXGZbrlsegdDquZo1Lt0IlJHX2TJ9iep8Or7XUMiBVLw5FYJ
 C4FMaaH+5xHHmk+9Y6K7xckwApQLx3kxOqgXTw8bQ76fwYBznPdN3Cw9REB6MQ3GubPL
 c2A8qihcmc6v13JLZH6//U4JkGioHyfkBl3uLiDI8Dmx2hNGhaexLYS/Ia6Tc0PgYGSd
 7orfFyoJHoHJg6sTIFeabrLwjUc6kphUZhOeNOUCRjrEVg1ElHk2BVEXw3ZPUCVJlrDz
 6PpA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4Tm2yin7t3GBNpp+zHZqFYGhsHqCVPaFHoku7xONQolep+OBKQWZRR5+cexEGPnB1WybiRGUiozI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywxlrg2EIz1vpWOg1DF43MwKwf2tUL8jAw0UB2cQvKkS0JHg+t7
 BcWopvcphroST5pzBBBFc4F4/IJisQAPnbHfpcOm0N4OGQ+fA5QuoTcBtlmZXZW7NB9d1L7+230
 cHev6IjuOGDezJ0xu9hSt0Sj+eelrkQ30vxzhYiD8j2BvIN81kJPRHopLJglu/+0Dn4M5UDzCEO
 wCIfk=
X-Gm-Gg: AfdE7cmXuCQcPahvUssVapPi6KRVUIY9igTBoDHT2gcwpI3fVNIpU57dmwfDR0hV4iV
 hXX70KDceMNmmelsCHuykZn9GJ5W2nQfzJkjpb2uRlU0T6b36AAN4/p14pf5QP/gnAWVu+YnEC5
 J7SUmFwgmtZgSbWKHKhAMs3VKj3EkodHGrEZObJj+rExNHvWwRVZXV0oRyfmhaZJseePXYX2WJg
 A/GxfqrQyQTgsFNmsPAPgw5CRxdFcKig0/N97kKrorVi1CNPPJV8QipkmVtWntqyeFTf2pmnKFX
 +qcZlref8VW/btgE68dMUqbed+v1jGtoXQNJ5ij9w4df3wEa0Uyp4QgSrRa3IGWGMk3Vh84nuSS
 W0vQLHMVa88Ye2qpfGK0eRyag3MnWYgSG4WxzUczaCOGPeuQTBcWCKlZ4G7NRm3qgY0G2bDHbAq
 jOT+lqTQ04dfq60SAtS4PVPxZ+
X-Received: by 2002:a05:6122:660d:b0:5bb:74c1:e2fe with SMTP id
 71dfb90a1353d-5bddf7181a7mr2298604e0c.13.1782995512854; 
 Thu, 02 Jul 2026 05:31:52 -0700 (PDT)
X-Received: by 2002:a05:6122:660d:b0:5bb:74c1:e2fe with SMTP id
 71dfb90a1353d-5bddf7181a7mr2298596e0c.13.1782995512414; 
 Thu, 02 Jul 2026 05:31:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aec89dc55esm654980e87.66.2026.07.02.05.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:31:51 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:31:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] drm/msm/hdmi_bridge: Simplify register bit updates
Message-ID: <f4vlbpxv3tuxv3hbko3t2qgtht5ofeyqiculq4ri6k44b4cznn@wqhzvj534m7o>
References: <20260702-drm-msm-hdmi-cleanup-v2-0-a4a4f0e8895b@oss.qualcomm.com>
 <20260702-drm-msm-hdmi-cleanup-v2-1-a4a4f0e8895b@oss.qualcomm.com>
 <20260702094921.3DC7D1F00A3D@smtp.kernel.org>
 <01cafc67-adb4-4240-9c45-af835c4269e0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cafc67-adb4-4240-9c45-af835c4269e0@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMSBTYWx0ZWRfXzgZiHqXmdAlO
 w9ol+mYaEvEkpBaI5SBnkCAg7/fJRq7hHqRC1p4uL0FdbJTUn8TWwiSuN6m7qIh0/okamJ5P9oe
 4oMghN9PAsYaqvDPMPirVr4z3i4kOXI0N//WAe7MB0o3k68b2h02ITxmyOWZeXYMV80FjPdltij
 wNxfTYkQSM4f0LpuVXCcfDN8RiR9KBZDsgUY6DHh8np8qbZYlrcfpEtQ6WKmJLallne9LiBiyyf
 vFjtUTlOOeGeHAFw85oW46u4zjat2ok7JXKWKjKVes/0Lu5s9mbsRB5qB2NrVYWm5jt/I5GMYvz
 ijs68nT3hqgBHYuA8wsBHl7pp/8da7bRqJhx2kyiD2V9tOgmmeTn2JFXxeWscg5UeNQx8bEBCfw
 KFh4gfynw1t2QFBi06n2gNDp8S5EYRiJLDu0wxnXfeZj7XdEdngUVEpZwT1K/lPUnLVLsh3sIIH
 W884QHOjnemaOAcWTcw==
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a465a39 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=7LRuesX3pLBna_ijODoA:9 a=CjuIK1q_8ugA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: md9MQGg5Uf55S18FICUTF-YxqZ8kWVtU
X-Proofpoint-ORIG-GUID: md9MQGg5Uf55S18FICUTF-YxqZ8kWVtU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMSBTYWx0ZWRfX+Fpqrr6JLgxL
 b77r2jUAEgTeDxRfAKsMdh/0Jg9VVJ3/GhYYp/NDOlWzIC+GGB81iJvAlSmiFfoZwmGrlObCgbA
 JVDd57UQvl+ACTrBdmQv80Ixc8q6mmM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020131
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

On Thu, Jul 02, 2026 at 11:59:07AM +0200, Krzysztof Kozlowski wrote:
> On 02/07/2026 11:49, sashiko-bot@kernel.org wrote:
> 
> > 
> > Because HDMI_GEN_PKT_CTRL_GENERIC1_LINE() generates a multi-bit field,
> > passing the data value as the mask means any zero bits in the computed
> > value will not be cleared from the register during the update.
> > 
> > This works in the current code because the register is cleared earlier
> > in msm_hdmi_bridge_clear_spd_infoframe(), but does passing the data as
> > the mask defeat the purpose of the hdmi_update_bits API?
> 
> The code is correct but I could make it more obvious or intentional by
> using here in the mask HDMI_GEN_PKT_CTRL_GENERIC1_LINE__MASK.
> 
> OTOH, existing code is very simple and obvious, so not sure if worth.
> 
> Dmitry, you reviewed it, so let me know if I should change it to
> dedicated mask following above tool review.
> 

I htink it's correct and fine.

-- 
With best wishes
Dmitry
