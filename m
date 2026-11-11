Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C9606A324
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gOVu76xY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J0O2dlIJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5283C10F4E6;
	Wed, 11 Nov 2026 15:40:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3CCE10F4E6
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:40:14 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABFPDEw014572
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yQk6KBaqCt7AnjmjWR01UrzG
 MS5fFH/wI09BIEpiKSY=; b=gOVu76xYx+vlF89Wx0tHLkn5HMSA0bxHxNqbsuoM
 sdeK11yjOFoTT6U4HpuTQIGsssZnLbmvN2qjkCxOWytdGOPqdIOwkwLBu7RpZcqy
 fsQRtER+H96Ffj6CNPw84qrmdSDlixRDp9cGFc4rjeyxgP+mtCU64vNpXpg6S07X
 WUiUEggNPylFKO4WU14JL6S/msimrcgDDwouA9ZkQQxbYgYVMm1IeOj2fiITsZcM
 0tVDpz3k5lg5gaugO3/4lhHb6l1/ezYOLE/YLpzf0stOdDPQ+Ls7+4p+Jec8SB0T
 o9oH6RYU1oisEbERgttHNzyStlx1G0Ylr3BKWT66CQEAhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvtymr31w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 15:40:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-944101e6367so603356085a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 07:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794411613; x=1795016413;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yQk6KBaqCt7AnjmjWR01UrzGMS5fFH/wI09BIEpiKSY=;
 b=J0O2dlIJga77LnqcGbjULk9rsTMJa01+Tze89jGHnTYh/j7Ko3ou9jROrql/oDGqj6
 giQIkGE1ObeXUFI7lmP3R/obTY4wryFJRPng6A0DXzcyLsgeG3J863N6JDjSsYkfPsLd
 694jjCGH9b1EGf5vKjwTXaIczeaWZS4qIYSbYuLGsb+NVG9qDOs9jOthnyaDSRhUTySY
 H+asGh+yJ7uUo/tYtkJhsweKRSt21MDePkDyfeLugh5CAo9f7i6As4ztnUrHzldCVyGw
 KUEo4lmdVA94QtGYuSjknXoYGO2AGp7nr+T2E83fJ0ybOCv+A7rXQWcGLJ+Dyz+LYMZd
 ePEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794411613; x=1795016413;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yQk6KBaqCt7AnjmjWR01UrzGMS5fFH/wI09BIEpiKSY=;
 b=qHGlIn4pHqOUcr0D9lMp63yUn0F1QuQuCCFRl9iTAoOJvuq04MyBSqSyRJAGPpk8Pe
 mdFFd51ladfLzOi+FFMjjL5URP4qhWH9rkQmUFwcfq/dOO1tCs9nn6GzR18ej1kIyNiZ
 Mm8XI07Gigfcnk5EV/t43KSXq+EJB6P4WKXZpYMV2JhPlDzmG9swKEI/waMoetuEPksZ
 T8H47QyN8Xw9wFTqk8rCjb3qj6Ewmt4ruBY3jTujpFhIvfndhCjLepCwPtMPpOeBXCET
 4h1U5NREu3iuZrqavvogPfBVIW8z/G+kWvo587fDWvRh6x3LYDImp3DjRxrPo1YykeVV
 IuWw==
X-Forwarded-Encrypted: i=1;
 AL+hErEBnnI602TdD5ViPmbQRZ4nU6b3RkUFr5V/4HqS3Z4j0DL4oO3qLNtGuMESl6O1IcZTNVdHUNQJ1hI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/K8igw9Q24cAv9qlgUpt9rjBIjFq9lVY1vt1zPdioJfklbse/8
 mvWLrgm1aYybTn870d2fojxc96q68IJ7fEDx6BSfbI0PvFTQQnzfDtyVbKwFt3i7KKDZv6sddc5
 e24mnFc78Kot1gKmhsrWOjCVKxG2YvoP4CUNCUo30vlLIASnIffiiy8ij2cdDmFGiWKc3qdA=
X-Gm-Gg: AYBFou3mgFReice0xVJQx7O8qg4xstOL4GDfqOuZwVQtas+YksDCAXqREimkpnH/i13
 w2ZELB7VnF/8ux4yMjQDHE3YsoY2BWXsqL1ohf/3HyGI8X6OTGqfek/rK1zxB68tDSwjZVHBZhJ
 guSZu6b5padJiAyY2cr9BDeU4bKGo6rDWyHBv7uypToV71qD8v6C3xzVtkJkAOCUonBnNTpzh1L
 fpKnDwvzOZiw90iECWkN8FQlWQCHgLe1UjyKxgkaKCOmzZcKkx4/ttGNkMflBShBHXmdrJcGWjZ
 +r/PHs7ch5Qa9j01x+X44j47uUZl3q0xQxd+U40YPJbF+anW5yxf2MrH3B7OkjUjfaDVdJAWdBJ
 qPQZety9gjakKNCo3ajdYR8KiX7xFwjMVvNs0OnyN+x6ry0A9u4FOoN2UtQxX9NkxK/ryL4G5Mw
 2QdEfxQUHL6SWEFzHcWlOec5OEtZqT1pQdWtP0EuNu99Xg3cKejvhOumdGPJUIIA==
X-Received: by 2002:a05:620a:8016:b0:93f:1789:8359 with SMTP id
 af79cd13be357-947ae88a471mr518127685a.31.1794411613016; 
 Wed, 11 Nov 2026 07:40:13 -0800 (PST)
X-Received: by 2002:a05:620a:8016:b0:93f:1789:8359 with SMTP id
 af79cd13be357-947ae88a471mr518121185a.31.1794411612413; 
 Wed, 11 Nov 2026 07:40:12 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae092293b0sm11877221fa.17.2026.11.11.07.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 07:40:11 -0800 (PST)
Date: Wed, 11 Nov 2026 17:40:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Michael McAllister <me@michaelmcallister.org>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi: avoid pinning the command buffer on every
 transfer
Message-ID: <6m4cssgagnpvm2wawyj62veoqbglxv62rcqgxzaxvjynhn3dts@tlkaxvd6ph3n>
References: <179422752570.88190.13452031230666113805.msm-dsi-pin-leak@michaelmcallister.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179422752570.88190.13452031230666113805.msm-dsi-pin-leak@michaelmcallister.org>
X-Proofpoint-GUID: ImEca5eaOExYT-_oeuIi9GR1-n8_sImW
X-Proofpoint-ORIG-GUID: ImEca5eaOExYT-_oeuIi9GR1-n8_sImW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA2MiBTYWx0ZWRfX94P2ylgtZkQw
 pH30+KSlIoqPWu4MgoPOqkVV21xGA2aqvmXFcAwFd5kau2fCpyt0lFAgM+c2D0ZRKfQTBIZBpIh
 SxoY7yXkx5Qn4uoNmizTanPlmi2kehGjE+m3ScTK827eR77hlkzktMfry74IoMnr2BneY8W8lAo
 GOrVRlxQBmhohU0fgMim00FtSJKVBf4KOFDcHQvWDmAxRZRFBEDX7FQTelxpVVDcXZSJAU4cHmN
 4jQ+XFjno4VxLse3MsyF9d0aV1uM7I/PIA01yEnhxKSzlscLBlofN9QHWGton3RzAltC57qHXFh
 lQ03nToBvlDkSEm+yncXmN/pfmgf+YzwwLnjkCtDL1L5gHMx5FvButw/yU2nxqx8g5JQ7IgVYUG
 F+F7dqx5a69msOaNV8Q3s8sU9xkgk1+TDhpcOHn/vY42EYvMbUk60lsl1UJlKbyp+PT/30CRu1u
 oTi2d3YVG8CtlK/fEag==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA2MiBTYWx0ZWRfXygs7zDZqmm/u
 mBCww98XFDKwHKNAwh/WesJdbUkP5pJS8P04dMXowchkPrD5tclYaK/4nh4Sf/72z21L3K2H3nP
 lY6wO5nzLPH2nZ2L+rm02RRMWuKKY2w=
X-Authority-Analysis: v=2.4 cv=Q4BHcI2a c=1 sm=1 tr=0 ts=6af48c5d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=JwJ85b4fAAAA:8
 a=pLk9kBtbcEIJPp8lWhkA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=qg2vb7sgHZQYDKbllo_a:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110062
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 12:32:05PM +0000, Michael McAllister wrote:
> The command buffer is already pinned by msm_gem_kernel_new() when it is
> allocated. Calling msm_gem_get_and_pin_iova() to fetch its DMA address
> adds another pin for each transfer, while teardown only drops the
> allocation's lifetime pin. This leaves outstanding pins on the buffer.
> 
> Use msm_gem_get_iova() to retrieve the address without taking another
> pin. The allocation's existing pin keeps the mapping valid until
> msm_gem_kernel_put() releases the buffer.
> 
> Fixes: 7ad0e8cf6317 ("drm/msm: Count how many times iova memory is pinned")
> Signed-off-by: Michael McAllister <me@michaelmcallister.org>
> ---
> Hi,
> 
> I ran into this while testing display teardown on the Moto G10. The DSI
> command buffer is already pinned for its lifetime, so this avoids taking
> another pin every time we fetch its DMA address.
> 
> I tested this as part of the G10 display fixes on 7.2.9, including display
> power cycling, suspend/resume and teardown with the compositor stopped.

Sashiko reports a double-free and I think I'd tend to believe it.

-- 
With best wishes
Dmitry
