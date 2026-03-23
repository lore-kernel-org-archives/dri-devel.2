Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC80D58CBE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 03:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A6910E361;
	Mon, 23 Mar 2026 03:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K8qUwsA9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FD8rrDhw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFAAA10E361
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:57:49 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MLxLRw2191143
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Nb3/CITWXfGqvBVscIbjfaZJ
 5Mk6dxgwW3bcBBm83F8=; b=K8qUwsA9r7aNPoQ1v2zEvjfZSp2BGLlNA7wy+maR
 kuo/+HQA/GFo28eWPURTvMWaqEsMZ9czmWDFDoSszwBu6ksuI2WFP2q0x1lOVTik
 cGqRe0iqnOagR3g48+CCFWe/ZRrXIzy9FSGAxYZ0yMaAH2c6jJgZWchiZ6JfraeL
 PmJ1bddAexlPangzKVEQPZEJChJd4UFkK3wA2wH69zOqtrDnafjIs7VpXLHpNq34
 pe6BXHh0tx/79mQXxnOkVZ5RcyfHUDgzpjUJJHh6s307Q/YN8pWf0Y6DqMEAbhBm
 mklx1tl+p7JGDN9japQgZ7rddnzWBvVSTBJGQEScDCJvEA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1m3cugd4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:57:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b4987c698so177793481cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 20:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238268; x=1774843068;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nb3/CITWXfGqvBVscIbjfaZJ5Mk6dxgwW3bcBBm83F8=;
 b=FD8rrDhwA5iu6ZGPjysPeQ3ryZ+RNVqnanzBV2dQT3GOb+DtxdtsNDJtqq8TPJBHlk
 WF+HNz+xvjgthNxfzlyyC70V6q1oHT2xCdU/RG3iRPipop2pFixWJo5ph/4ezP2piVS+
 VzxsaJyppaGA7K3RdyMmBcbFLJYDyjmEBABPDJBzILrn/pN5lKLv7sjKcW4hjTWB8RL6
 sXBfAd5P0DKpP+moPQG9wOHHMN6jDopzAAnmbL/RNgarAuHW2LmmxqWvxh6fZf/XM2oR
 Ysch1Yzn3gRL3A0fLYv/wb5FJkXjVG1wSIGAU7qWgS4O3CSDKREQ/c+1OFCd+Qce6+5V
 icWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238268; x=1774843068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nb3/CITWXfGqvBVscIbjfaZJ5Mk6dxgwW3bcBBm83F8=;
 b=aio5gm4kL3kmAu3eDREGFg5uuHju3n6N9/2trPoPoObUWWoO/3z8t6pKaC9v2S2nAb
 XUMjxOaPEBZdu/Sxx8KBNewJhd6YBMmC+rU4dNG6sWa+83wlBVbu5gbw9vmfm/8mSMLw
 jRyd3WwSA0PbwL6R4HpOJ/NOFvS+kGOoAjM0yBrqZGjw7u4Wf38H51581n9gCH6Vjiwu
 K41UFZyzwcgIVsetn2Ti+xUWp1gtbQA5vttUuEjoYqnlBeuXsQZgJvAZUK9s4HBEuba5
 uDoigYG77jjrHSTNe6EGwI8An04k9i4tLSvwKksdLtw+T07+J3yHuec39vXxkUiKiOE7
 S3iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU31ohI/u+ZmA+SQFVMXp42NAlDqSNwMlHTq9unvDuR6Lt4zWk0oXv2/2vPSM2hv+Yptc/LPPdMtE8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFeSFguZwzCwbRz7UU58+AgzkQv5kYogNQwDHfaftrcpaJM+HU
 +xEpDC7B5/v9gugcHkZY0KU4sklUCoOYUwnCn83KFTsVkBXBs3iDTjUryTyy1dz7ntzHtBPNt3F
 OIYFPc3qc6cD2qX8kBRusHkASh0uh6Bk76ekTYh9deSHcwUAUQEDdy+PtYVNF1Rsri3LQ5M0=
X-Gm-Gg: ATEYQzyMf2/nSEhSvLy+yZU10OEG0T+7ZI4fOjNSWX8WFGqkIQ0rCLqP0+Zc5EP+lOX
 G7DR1d2LkGGMC1+UEuYQAXs3ry0jOeX9tFkrNNX7VDsKwZNQrblbLmz6w6vC0DCaETIY3kD+Rtw
 9g5MCngDNOAQMO3G+Ekia1+AEV4Ra4kv4LVmQA3zi6vEI6ZXhiTZzwceP6vhZ1JhuAwce5xZcyA
 VoGuyucyNBSSNl7rPKvZFB92UxV/oxRD3u5bUpgAeKGz/YcdQndQxMcWJ5fCBQOZp0l949LFjfC
 rXMrrTDdeuJ2v3sBwpRGkjedplhkGZy2MysQyWt5Y0df3As6zWJWgVwJGZkR9VTOLFgr1NQ0LTf
 EtsFmc4Zk9fz+tPQLNUmuG8fHIJuC1+7eEBOgs5X02+GxszEJvznkKi5UifzSmf4g08NTmhovyc
 6M5lp87eeIuNCl3u3btxVtM+zgstNqrktvlAQ=
X-Received: by 2002:a05:622a:1787:b0:50b:5743:5fca with SMTP id
 d75a77b69052e-50b57436501mr47168541cf.39.1774238268426; 
 Sun, 22 Mar 2026 20:57:48 -0700 (PDT)
X-Received: by 2002:a05:622a:1787:b0:50b:5743:5fca with SMTP id
 d75a77b69052e-50b57436501mr47168391cf.39.1774238268006; 
 Sun, 22 Mar 2026 20:57:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2853055bbsm2237555e87.60.2026.03.22.20.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 20:57:45 -0700 (PDT)
Date: Mon, 23 Mar 2026 05:57:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 00/16] drm/mipi-dbi: Replace simple-display helpers
 with regular atomic helpers
Message-ID: <ltxdlbnllcelmlakfjks5oo6ys7t3h6lulxaev3jmnumkjcebg@3dwu6chuswrf>
References: <20260319160110.109610-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319160110.109610-1-tzimmermann@suse.de>
X-Proofpoint-GUID: XXcT4J7n2ogstB-CEp35z48J1BNQm_SH
X-Authority-Analysis: v=2.4 cv=Z5rh3XRA c=1 sm=1 tr=0 ts=69c0ba3d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=AFjOBgLt_7CL9iCpBFwA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNyBTYWx0ZWRfXxkyrZaddJG7T
 tO7n+vZPLLhAlNrhzFug3L/LNoi/UWxhvqMKOmDSn2cuuOGOuuwqK2qzwUuAmSUnV6tMnSEAhqe
 oF7cL0p9EyiAjOqBQcY3rVENJ0SqtS08NpmgnSe969hO/0Tr9EIaARfowGEK+DA+nDKo/163Uhk
 hiJpkKKmtPjovRupUCH2jidSt/edq9J/O0zaKfId4IHPlmhE/bCq4DkZ4vzYc3IpirK1lG+aesu
 WKEuguCVerVWEfqZyKIh3+5bf7HzcajfGTjPb/46+SkqeiNYRmGfX+ACckhOwdnpnLnoFQr5Y9w
 FvlxYY9Q0kCcLsntPPbmnLjrP6jVWP4DyecO3TLqrov0hqrBIZHtiBUEllsoxunlCgEYcFok/Ri
 UnP39AqRec/oXIu05W2Ylfdrog2b2uGyA98aaH3MsQI6GAv9X5173Q4RYzYxJQPjU1fcCpACMK2
 a6Z8Q8ZHQLGxBudqzKA==
X-Proofpoint-ORIG-GUID: XXcT4J7n2ogstB-CEp35z48J1BNQm_SH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230027
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

On Thu, Mar 19, 2026 at 04:59:36PM +0100, Thomas Zimmermann wrote:
> We keep getting new drivers based on the obsolete simple-display pipeline,
> such as the recent driver for st7789v panels. [1] But submitters cannot
> know, as the simple-display helpers are fully documented and still used
> in several places.
> 
> Hence, convert all the mipi-dbi drivers over to regular atomic helpers
> and remove simple-display support from mipi-dbi in this series. Then
> undocument the helpers and add TODO items for final their removal.
> 
> Patch 1 changes the mode-setting logic to get CRTC and panel updates into
> the correct order. This patch is probably the most fragile change in the
> series.
> 
> Patches 2 and 3 prepare mipi-dbi to allow for atomic helpers to be used.
> 
> Patches 5 to 14 update mipi-dbi drivers one by one. The st7735r driver
> requires some additional minor preparation. Overall, the refactoring is
> always the same.
> 
> Patches 15 and 16 clean up mipi-dbi and the simple-display helpers.
> 
> These patches need some testing, as I can only compile them. At least
> one of the drivers should be tried on hardware. Regressions should be
> easy to fix, as these changes are mostly refactoring jobs.
> 
> [1] https://lore.kernel.org/dri-devel/20260221071351.22772-1-architanant5@gmail.com/
> 
> v3:
> - fix uninitialized variables (David)
> - improve documentation (David)
> - clean up

For the series:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
