Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4F8CA601D
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9D810E0F4;
	Fri,  9 Oct 2026 16:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TWveqVRi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NzbL/hNg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5268110E0F4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 16:45:32 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Gbit03350188
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 16:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6SQK/COtAtg9hMbyJCE+mvI9lDv2+zJwCTOnpgFqrKw=; b=TWveqVRiPYWOPO3H
 gX8qKGU+aqGjRW4uS1Sbs970xqeX4iMi+KLfGxpVPsytVXEsGKnx0ntNZJpJtar5
 AnKNloCWcA6t/knsB9Il2KNrhoGkryqLiDs8zR/K7nIhlVPqyPBa6QsSmTKZR8Vg
 8wSsgjqVPg6oXbupWk8DqGphE5PWAI6kRbFC6vIEgn75nSoN+wBCeIdeWaYbHgFU
 HcrT/u7FLhw/xs6imWaUIZawUv8X+/rrO/A9O59+LtxnXk3VWPR/z8BpzRxOcCzi
 UDdskgYPp/gtl85+TKzC3UOiPSqCNBJMzFQ3iohZJ3zVoPqjelWqv8CC4vRKvVKd
 aQZcDA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6nufuafb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 16:45:31 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-67697e6dfdcso13643699d50.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791564331; x=1792169131;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6SQK/COtAtg9hMbyJCE+mvI9lDv2+zJwCTOnpgFqrKw=;
 b=NzbL/hNg2Rsg4ymY6wGMdHztT6MuxL2c894wcQoDAiTlPeMJrSALwcyJz4Yi332R9N
 yDBpFlokxHA1JXQuGBpErVYcKE6ysvtnNhgc0WSZg6VykfmsPAE5DBf6xm4KrJcDdXeL
 yXPcAuVAGCv7YKiOjWEHHsnm5wWtqB0jZu2iD2t9CCmEJthFkkbKpdtU2J30q/XNahXk
 HoQj7j84Exh4dz6gQzerWgPP3vGRmbkgl+dBIvybmiJzFKutClPphAzGmE6+rBEM5ORg
 sUCmAq18fUBD+sJIfxj0KqvG3jLA2QVZOPJUGY/FWarcLT+hpKk2hU4pLFuOBbare3eo
 6zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791564331; x=1792169131;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6SQK/COtAtg9hMbyJCE+mvI9lDv2+zJwCTOnpgFqrKw=;
 b=jMHz/D6792ZBzZHdWkgcXthUwliGYxdQqzrP9KxAra/RPHqBSXaDNt42UErUtAS93u
 IWVRJzhj6Ku+4ZllKOPvMxj0xIQaUgzlxPy0I67Fbtg8ROCn2bmHrTLwy3ZSEeVFFUmZ
 EgGvi4w0gUmuNLNZEtzjPUUfgyxsy4BWrPUQCsmQYtdUwUi11JpffmRPSJmhhxE8tSFt
 Ra4MiHSsKjnF/QDkvNnx8guA7iL8A/mrVur2Awq9vWvYY1VkPM+n1WahhUDRwr6EuWjp
 FTnolUG8+l1RU+0Z60Solcw/OuN8HjyoHMpiVkz2M+DxgF1ae8jfMsxFLPQERFqQq1ud
 huHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1sPY4Quh+xL2repemI2/Tq4VO6QVfkCrtt61Nu7VLAaaKZwasBHsxwOnEj+NZEmPQlDJ/DuwHzY8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJBpURl+t2Fof4M9sYTqWipe5VsordBROXDfif7TgnuF0Gdgd9Z
 9z0VWVPEkQty2L0Bgakrzq8elrZmQCXBIIuX6SCU1WxeFOwxjHqaHOoFTBfRKcJ7G8tp2x6opMU
 EJfrB3fk0UPSVOsVfGRt/nc80OKCj1BJEEokdYZ8m6Fo4P5d4WzDvJ6uifXeIRCcOVQmFdFlxCr
 XHwLo=
X-Gm-Gg: AYBFou2p1/tnkyj651rkYX9CUkN9Sn4m7rt3bnmdbQOLjGlvo4caTghXs51D5BhRk5C
 v7f3r2k2mXQw5BA5H0qLrvI/Y7pepqwtd3Y5GKr/DCZ+dMB/DTDskUBKIgPvaBX342712EwHfbX
 jFU45ihGHK7rMkEO6+AldsgBARDm2OGGZzLPiRRG7gnMbrSJM4/lZFaC5zarzueHjcJMKjY++Z4
 HVvwex0ifT5DSe4aBbvU+7HqeIEqATRYXz3dcSKrdBp2eQ8CLHwxtKEFqmlC153X60MYMGbzW++
 AaKUZOebELhXvh1jurT1vjAi+y6W362fdArHDp1xj2RJT/qGbn18Ho/6sCfz4JUjdwBRbXo54yt
 16mkhNVrwTC4dzHS38cnXkltoDbepV5BEoS5wpWaubuohlDj5Dg==
X-Received: by 2002:a05:690c:c593:b0:8a8:a8a6:1c4 with SMTP id
 00721157ae682-8b07ec98ebdmr5633327b3.14.1791564330521; 
 Fri, 09 Oct 2026 09:45:30 -0700 (PDT)
X-Received: by 2002:a05:690c:c593:b0:8a8:a8a6:1c4 with SMTP id
 00721157ae682-8b07ec98ebdmr5633217b3.14.1791564329903; 
 Fri, 09 Oct 2026 09:45:29 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b07f1b7d11sm9864857b3.13.2026.10.09.09.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 09:45:29 -0700 (PDT)
Message-ID: <30176266-b153-4576-8cdc-a1dd71a5e654@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 10:45:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel/rocket: Don't tear down the scheduler when
 drm_sched_init() fails
To: Sidong Yang <sidong.yang@furiosa.ai>, Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261004164727.466164-1-sidong.yang@furiosa.ai>
 <20261004164727.466164-2-sidong.yang@furiosa.ai>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261004164727.466164-2-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=afn0Dhot c=1 sm=1 tr=0 ts=6ac91a2b cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=q3Tk2iPKN766HrrW7T8A:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX7kaZd41uOfGH
 IoI6LpC6QDoAc4bR76UgV3J3/7+C2+yhSe9OMjo/LFgmZ/IdXTT88uzIiTmstanQvexBTQXou5s
 Sm3aYHFY+Ly3Am86yA510V47SZsboXA=
X-Proofpoint-GUID: Ndph-vKxsOgIgwa7SXZjEM_qz4PGZqLA
X-Proofpoint-ORIG-GUID: Ndph-vKxsOgIgwa7SXZjEM_qz4PGZqLA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX4aGce4svT1F2
 dprdopl9tURmJthMkc4qSiqU7Yj5X2nwzj37KqBUq0zcQbFDaFsQRc4WSXMpCluz4LC8E7eEi/C
 4xdokGp/HHHH3MAbPnLaeVAvUlgloi3S1tEsSE4e62DE8QC8P1CISFSYi29R1Utmr2hLjFkqTmz
 P+Cjxw0qaUfxtU0rFKlQRyW2yajw4ujUdOckul161HIeqQ1bn8ecoIZI2DAFaAEktEUa0CIVVC+
 LdhPuFOhjyJBsBrTNtbVJWhNnEqVDKA4pf1QeDsyFzrB2M9O+sizY0LQXgOkKfjAHuRX76c3/5e
 hax00559cu3z0BVR1XxKN0WelTclLb+nCQSKKdedNdziETdjKOgvRyMn864UTS5QBVE549+nI01
 D5QVJVO0/rMbRbhRfc3jh82WGTkLKOeuuAy8oVYkCF5qpYySlvbEeFrAjmQiQE/8BP49zBDzsLi
 g/sZtIbb6dRc9HzwSyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090066
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

On 10/4/2026 10:47 AM, Sidong Yang wrote:
> drm_sched_init() cleans up after itself when it fails, but
> rocket_job_init() then calls drm_sched_fini() on the same scheduler.
> That wakes a wait queue that was never initialised, dereferencing a
> NULL pointer, and can destroy the submit workqueue a second time.
> 
> Only destroy the reset workqueue on this path.
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260912114524.7A6131F00893@smtp.kernel.org/
> Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
