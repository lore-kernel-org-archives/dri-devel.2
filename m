Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F46D606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kv4OSASr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mn90F7Xo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61E1110E359;
	Sat, 31 Oct 2026 20:21:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C6310E009
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:21:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VJFrd32617922
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=B3Xi0jd2KnKgrPJ6ep80cd3l
 +8cBf4DAA514CH+g2eY=; b=kv4OSASrS3Cpiq2h1eVHDFVrHfu35u0+0ecLTj2Q
 aExk9rf+knDIy8Ltfu8OZ425fp+lHKY57/8876eOh6fVgg4FDVN5dLmAb+E2MTqh
 bHRfoU6CBKwYM655l/oQlUrX0w1NEHMvTC1G25M1ztdj9yuycmAS01IoJcE3UPRD
 JoGlElNz+wBWLHqDxmGv3qd5OMrmpESTQYlux0gFE6vzh8nOp36ob/W1nacZ0r1r
 gnMTyZRMIn1enExLZnAVVxQvSZw4g2KVLIlYY4NW3qhF2NpXWUQ/VNbegbsykIb8
 8zni7U1/cqvBTlQiSvo2Om+38WL1ioy6cv++FaON/3k7NQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7nft3j1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 20:21:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c70349f65so38028086d6.3
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793478102; x=1794082902;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B3Xi0jd2KnKgrPJ6ep80cd3l+8cBf4DAA514CH+g2eY=;
 b=Mn90F7XomUC8mJ+7jAbv5bFaOzULoLHAos8GJLIZMHdPirOvRlyx1yyMp1dHsIHzSH
 uzEMMDUtz4hR87sj1IFj57COG7EUe3Vz3ZhLjolX2iqMHK3RrS+w4YFVhCuYHS/TFm/d
 kQEg9F4hCfAR6vFXFtvc93qPJgzgQWb4ql+XKMHJ4xvUS9tvAp32GiIWo9LDFbE1td4P
 UmJaOdPd+MSS4zGjEdVHRo1TEvaD2rTqrTne9DTfW0PeIHdjTzkyXnnNlbWwL0M/QnlN
 RyFXOleNuH1YP4sA9L61L7Z4lwCasfqpZhonV1gLOHcg2KYAxDBHvoJheJqppjq14B7+
 OiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793478102; x=1794082902;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B3Xi0jd2KnKgrPJ6ep80cd3l+8cBf4DAA514CH+g2eY=;
 b=nuYiG6WkFwn0djnsgRzbF4XRWkRxy3OOLudaXayNaN1Xs+4pH5dn70GXf4Jdh+prPc
 bp1IHwtxfdShIw1bUOvGRObRKeIDGjKYKGOoZZi6fVHqWY7EAZ4TwNJIlOI4tPbRXWtU
 Oap5EL0cwZU5E6ZiOSsk6zyssr9iG4vCndxxIlK7P1CMZoke1pYO1C/gHt/wjqNr1xW/
 pa/82US/Pw81l07L5Rc/CMbHUw1i93RRxxISjgismnxV0nqDEv9qMqW8y9fkQ1uD+L1V
 hNzvaTzqNYfA5Ls9hcFGKaClX+xCaqmncKGFuHgCat1nL+WqAH5O2L3oPmJFytzaeAtF
 Ezqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBybvupXVFInr91YBqbycNg/nQbYOJe4Xvo/NYohxWyIKdo4GpOJ+niNylKWbbGGzSxhYDGWs42Ec+w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLVav2dursasCxvCWHhQdkwQGF5L5rQKZlzF/ZdP7OksT1ecNf/
 cGcUjitJ97fW+ojAk6GxY/Xcpbdi/a9y2igHwlY/ytSphqREqgWe6l0Uo9VpNRP/PElt6xzklNK
 EdWcZ1YFZw6Hp9ERqtWdnk3XtmUs1XYpxdWnkeXr33cKUVU7DGhQFz7M+SoStxpENJVv4tjA=
X-Gm-Gg: AYBFou3X7liXYc4n3HRWgfzI+6ILklv6KM7d+XckUT9HHFan12OPDJq2BsqluxDmg6r
 xFfF5/f4Jj+A/+g/uDXXFlL6iRtbN8iP1+MtnDmqsJqoa0GEBAT0yAoHfFuCCR+mThOURuoNBZy
 LhrN4Y977rqHF+mnXH5JcpfcLs1DnnLwn8bPcyCY2VVfPpV/n1cmlW4gJPNjJMMUDgmjaDEnOVD
 vDkYXKwGfUHOhksL92C1qNRdBxbfo6wEBYlxPuPEwDS5wN8obqLWSkD4NFHsddXogNBP3pRPY9c
 SJjPl1MOihznGUt4ZumZvsfeN02PQ/7MLG3voax5+kfBmn1lMCWzlSNAbXgPV4acilVKoSKhp/2
 iEOemBIENqH9TkBWOwUo2BZi0CgM9JgOYbxTk9WXQyXv0IpVKz0TAFQOMU0nM2t4NfdMaW9O9V0
 pfccB/OpL1fJJ5nC8Mt2/pl3lhI99M/8EEcTcfSBjug94bHKcMheLEW0JEQ4t1pw==
X-Received: by 2002:a05:6214:4902:b0:91c:60e8:a8aa with SMTP id
 6a1803df08f44-91ca4baf013mr85236196d6.49.1793478101598; 
 Sat, 31 Oct 2026 13:21:41 -0700 (PDT)
X-Received: by 2002:a05:6214:4902:b0:91c:60e8:a8aa with SMTP id
 6a1803df08f44-91ca4baf013mr85235896d6.49.1793478101049; 
 Sat, 31 Oct 2026 13:21:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acbbebddacsm12698671fa.6.2026.10.31.13.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 13:21:38 -0700 (PDT)
Date: Sat, 31 Oct 2026 22:21:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm/msm/dsi: collect bonded command-path data into
 per-SoC config
Message-ID: <j5ixobskknatvusosmhgvvmnze4q67iyfwk6gsa3y5goovx4z4@mhumd2vsnfkm>
References: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031150305.1107572-1-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX7PqTImyfpIpO
 XyE65CuXJ1V6AuunH/5S2WjtQgr5Hm9gKT9S9Pm7Gcy55GJi9a6Fdm8/PZq2hd7EaXlA+Y6cpLj
 8NOq57max9A6rJyX/z+f6NVBcC9yDMo=
X-Proofpoint-GUID: V2TFQMj4asOxhCGiHuNnn8NNyTQmsb7n
X-Authority-Analysis: v=2.4 cv=FJ2OVOos c=1 sm=1 tr=0 ts=6ae64dd6 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=CeVSD1skKhO3MnvAeOMA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: V2TFQMj4asOxhCGiHuNnn8NNyTQmsb7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA4MSBTYWx0ZWRfX3onGt8Saf5xK
 p+4cF9ozgJhxqs8Ltn3SJIUjJ7tbSMXWI2upcrmm+bDtYu9OWjSEB+ZieJ4cKUxzS1hp7Qy46V3
 vRdDeyN4ICfKpgb4Tf5qoDUaEcHHMnSPuGZpXOBvsnVvAFQOjCzS/QEkqbM58Xu19TcxIHj+6fB
 jS0M+5S4UTHRVqF45v/DgINTEgZA3//UC1FCQqUrMtuMWe04IshHcM3iqRPThmVzhvV5pH5G5g3
 fjPkkz7RwnRlDGDU0D5mie21Uol/u6b4S6IrJkIbjRvpnWYE/tjSgHzd6OsYLXYyhRvjapiJWD1
 gtbZUKtLopnwYcNkfa+iGhfh5ZHDPwAZSls3Ke34aGCS5qvI26pHCx2x+9CaWjAvv8cx63LBoVS
 Y6Ks61LfiSpXEKim0Byg5Era+UhmrAFUzub0xw4yAxuTjgBhSz36lFEQziJ/s22H4MYtvHEuHrC
 b7iUEdgtFlL9xAfGEIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310081
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 11:03:00PM +0800, Qianhui Xu wrote:
> *** AI-assistance disclosure ***: this series was drafted by a coding
> agent (Pi) working from the author's design and measurements; the author
> reviewed, tested and approved the final text. The design, measurements
> and decisions are the author's own.
> 
> The sm8750 (Lenovo Y700 4th gen, TB322FC) uses bonded DSI: two DSI hosts
> share one bonded link, and the master is decided by the SoC generation.
> This series is preparatory refactoring of that bonded command path,
> carried over from the vendor tree:
> 
>   - 0001/0003 move the bonded command failure flag into the DSI manager
>     state and route the command path through host ops, so no mutable
>     bonded state stays file-scoped;
>   - 0002 collects the per-SoC bonded command-path data (FIFO error mask,
>     CMD_DMA_CTRL bits, peer poll budget) into a new struct
>     msm_dsi_bonded_cfg hung off the existing per-SoC table;
>   - 0004 takes the bonded master link id from that per-SoC config
>     instead of deriving it from probe order;
>   - 0005 names the FIFO error bits instead of using raw magic numbers.
> 
> *** NOTE ***: this series contains NO functional fix for the Q28 panel
> issue. It only re-homes data and names constants; behaviour is unchanged
> (patch 5 is explicitly "No functional change").
> 
> The bonded command path that this series re-homes is the one the vendor
> firmware lineage on this device (SM8750) drives; the series introduces no
> new runtime behaviour (patch 5 is explicitly "No functional change").

I'd say, I'd prefer to see the reason for the changes. The bonded DSI is
seemingly working today.

> Gates re-run on the final series:
>   - checkpatch --strict: 5/5 patches clean;
>   - make -j26 W=1 drivers/gpu/drm/msm/: 0 errors, 0 warnings;
>   - the series replays cleanly, in order, on top of 0f1fb1c9c1.
> 
> Qianhui Xu (5):
>   drm/msm/dsi: move bonded command failure flag into dsi manager state
>   drm/msm/dsi: add per-SoC bonded command-path config
>   drm/msm/dsi: route the bonded command path through host ops
>   drm/msm/dsi: take bonded DSI master cfg from per-SoC config
>   drm/msm/dsi: name the FIFO error bits of the bonded command path
> 
>  drivers/gpu/drm/msm/dsi/dsi.h         |  21 ++---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c     |  51 +++++++++++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h     |  30 +++++++
>  drivers/gpu/drm/msm/dsi/dsi_host.c    | 123 ++++++++++++++++++++++----
>  drivers/gpu/drm/msm/dsi/dsi_manager.c | 123 ++++++++++++--------------
>  5 files changed, 249 insertions(+), 99 deletions(-)
> 
> 
> base-commit: 0f1fb1c9c1c8f09c711e8e9a82acbde2baeed691
> -- 
> 2.53.0
> 

-- 
With best wishes
Dmitry
