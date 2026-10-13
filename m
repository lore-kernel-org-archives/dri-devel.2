Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EE6CA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C95E10E7EA;
	Tue, 13 Oct 2026 12:25:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00C210E7E8
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:25:27 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8J6Kq922862
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0NaLOGfX2FR30Kjmhhwie4bd
 r4Qy5ir/Fkx8U79TvF0=; b=iQCq8H9tMWMtZQBBjWDJmZqLL9S4xmpnbamlAJoS
 bcRqdLFO4iJGe+V/BaJxhwbT1J5068qD8R51nI8Y/uXLxyfy8mXORI3E7k+CTCiB
 tm3O76pCluqyX3lBcNxyApr0PgzuMMCQxPP9v6/MLO3bWQ2mivv118p8Qo5dPWGv
 oSARY+u44+90XfPTC1pBw3RyyQy0u82gQVCgQDR25ZnlPQ9+47gY961cWCfn/MJT
 Vp58deyFNeQWXvQK9bD1gqQurNep2HnhiRm5+Ty4/uhLw5BAWoCqsbE6i07DTY+T
 FBIoyzglwYHEeP9Zo6Dn0fVge8EWfJsef7H1LqvhRtux1A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1twba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:25:27 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91b92acedd9so34968026d6.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791894326; x=1792499126;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0NaLOGfX2FR30Kjmhhwie4bdr4Qy5ir/Fkx8U79TvF0=;
 b=ZN7R7md2DauQIN9Z2m4lbVJCgMFfT8fZrA4tEp+jRZEP+3D5tZl2RwV2xt3AMFDI3I
 RbZAr82DCigHp35SbmF2BvIbHWQrmNAlAL5sFM6pyXBdF4lP+X5j+1cniJ/ZG3O7J4sc
 JUfP/bQ8JWM5NvcCWeqYZytPfCRC7i/GhkjlUNCzfodJNFzmO6RkOsxFUz8qtz5mKtsr
 bD24Rb4v5DHnuZWNgrmB795SlF27b84Fcjoi5Psg6vwpVNWsS+hnMaVbc6erCbGwYZAz
 GzAf7CHtTmAzCxDqSZW9Wp4Nl0i59c58i4w1v+rHM/ALJhKIdUWi5UwP+jzy3kv14up9
 8Itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791894326; x=1792499126;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0NaLOGfX2FR30Kjmhhwie4bdr4Qy5ir/Fkx8U79TvF0=;
 b=QYbnTrjLB46hsHUsO2vsDkvTkd467dQxYU+e0EUKH0kZU+X//nfFQN4C4O+nkJhoO7
 f0oqvWqCCOMyvdImVjNDu8977W1qTwmwmyGQkNZ3aocxyWsFJ/IJVUvjIKJoaB3FnFRo
 8K2crulg1UsU4TZ2yi0sojlifz8WO0dYLILRWtNvhwPkWoB1hRho1l3iTh+/OMNSzAKZ
 i/FNzQFevST0mvc9z03Kf5f/Mt+4YxbRDeiFBf9RepZS82xYFa1zDGtP4rOXQAo4DCUY
 YFiFDSPy/z+5OAL4frtcJfFRSjKQVfhf+OHxiCuIkP9BN0DhWZMsuO2Bs8+Bf8e7b0Sc
 0oJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBycWCyDfEGYYUzPOJYSKT8tdgROOYcmf+kqPuv9nNImn1sJWKUEi/gJX+1hPae2F1ULY+JQvoND75c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL01N6NzaZGTI5aM+bnOdm1AwrSkIhxqX/spmEJIQShnzRGeBvW
 KZRy87tUWb9EzApcq1UjGgUxU9dFRSQPXYoDH47GuP3BEzdZbazFoJT1Qk3CaZyoptsFfma6kSu
 hCs1X5qtmUojINg6HP0zPRpPAXl85oOZLHpFuFDF1zurMe3kUsmccToWfqXWCD+4SuyQwrH8=
X-Gm-Gg: AYBFou268L2Q1TbAATBb2ZcVvvSEdpvBnCKPVILGsww1PVc5zJ9TL9ql+syvxYUz4J9
 0EhFvy18ZsCTVtFptrq5wIUMC+KhWKW8VNjbJex/v1mRjsdW0g+9a9nhZ73jcQ7rQz5GN1JZSpB
 BE/r3kXcpvQRg7X9P9Jt8zKECyprKQbji8ZqADFi18SetZMkfp/evpVifSeFsoI1vNJvZqvgIyo
 nvcn+c1xBaH018fGeudJvR4P+jtsevX6xhLHUbyHz7rDk55IinUr0mOa4pAv7ZXnerAN4u1GQ4f
 kjrUoh+pwwqY6UwW/FdF4/gEvOgzAaScmO4qdA92BrgUlSN0s0rvoUQdPvv5bBpiqMGka859aFA
 LJoJ29eLeMFtrv8XUf3HY8oCDxFjaI5nP/x+eXChwvFN/c5pndKRw14l6fO1uiaa9/FMNrvT4PU
 NR34zRtaC/y+d9
X-Received: by 2002:a05:620a:4489:b0:93c:5c60:c3a6 with SMTP id
 af79cd13be357-93ebd2a6dbamr2056678785a.66.1791894326307; 
 Tue, 13 Oct 2026 05:25:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4489:b0:93c:5c60:c3a6 with SMTP id
 af79cd13be357-93ebd2a6dbamr2056675385a.66.1791894325758; 
 Tue, 13 Oct 2026 05:25:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddeb5826sm3556465e87.62.2026.10.13.05.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:25:24 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:25:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/drv: stop mentioning deprecated
 drm_of_find_panel_or_bridge() in docs
Message-ID: <mjsbtv4bm5hvdtmok566pqmmoveb5vqyo5cz75vqcta742xnd5@vuavhsjuoc6w>
References: <20261012-drm-bridge-every-panel-cleanups-v1-0-0fd272f486b6@bootlin.com>
 <20261012-drm-bridge-every-panel-cleanups-v1-3-0fd272f486b6@bootlin.com>
 <20261013121450.GL56180@killaraus.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013121450.GL56180@killaraus.ideasonboard.com>
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6ace2337 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=P-IC7800AAAA:8
 a=P1BnusSwAAAA:8 a=EUspDBNiAAAA:8 a=mwiDrI33pxUzkAEjcyAA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-GUID: iZZDU3tzVrPsFDQ4loIQt6HlL7DGsf0o
X-Proofpoint-ORIG-GUID: iZZDU3tzVrPsFDQ4loIQt6HlL7DGsf0o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX4s1wZITOtigW
 8Iin42ALSU8+2BZ7yRMhQ20wWiXr3d3CZJo9BhWQAJM0NSZpZ8Ez+uUot/j0Yc0GoT9KRC5M196
 x1UFLd+j/lLvuHzEFS+CsmgA3/WBhdc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OSBTYWx0ZWRfX0Dq+oV8yjxOz
 ei1X9aOR5WoLisVNquwcPhjACocddrqB3fiEPKTj0zvepNVSyO8U1aHADlCeuzHZxji4/uxGn1k
 RcxHBb4Q53g/4CuQpyTrQl72ZF1rnSnVZhPBQy9ljCOx4eu3EuJZVxny7MYaFvi2ab3ujNXgSTC
 QOn3xVoIEsZZT8VWOohyXyuUrh9gm/ZlGMefNXs38AIQ6Jo8ZMZMLStNJn5svVxmxzHCArwzRKS
 HywuSBo/xK5DZkSA/eZwegROpslEcBk5xZZSIW/BGAQAQcnBkgEZALfNjoIoobAtYUPif4L75Ar
 YBJ3Og8tTeFZ06Qb5CigdA4+VfTwz//49sZ55/9vIifEqmpgU27ofgEg5xa4GPzbo88nDK88DOz
 PX/jZl1H8BYM64GSAH+DcfdJXl+TVSf8kFO/+jkFldpCfQ8WDrNYFBx+Trmph8P6V2Jf6JBF2T9
 po10ZBRMtrp1BXTyD5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130049
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

On Tue, Oct 13, 2026 at 02:14:50PM +0200, Laurent Pinchart wrote:
> On Mon, Oct 12, 2026 at 04:29:53PM +0200, Luca Ceresoli wrote:
> > drm_of_find_panel_or_bridge() is deprecated. Update the "component helper
> > usage recommendations" docs by mentioning the currently recommended API.
> > 
> > Also stop mentioning drm_panel because now every drm_panel embeds a
> > drm_bridge and the drm_bridge API is recommended to access panels too.
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
