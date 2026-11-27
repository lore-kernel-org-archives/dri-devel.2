Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993E606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GQF1KC4P;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bAXxk9EG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B86112D9B;
	Fri, 27 Nov 2026 20:27:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E47B112D9B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:26:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJBQQR3348472
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=U+MQls5F39eaWPhjl5MOMa9Y
 QrhfhFVoRGXfaTrSITQ=; b=GQF1KC4PbWynR9CJFchk9/7bYAyxHQue4mwXHVsF
 vRzaJlreZErl4vt0XczOpaRgow+JUL/76U8iCfJp5YetHXnfJQZvOEWB0D0CVJbU
 1/4d12SPitQLg1XhKvSCyxKVqSlXDfKJdVctW0WmmcKuG0KA/JTXWxbhzZypc4fU
 8sjN6JHCqHYvKqoj1RDou0WzTHtFOCh6wIdri2ZeCivWu6G7rKDuu5+U7oeoua3v
 QP9q5v3OG/r9r2OcTDqkfgolF/rXtrINenLV/7utOVDWBYyBBdRKYhhrimvkP0W6
 Xc9+RxLIKGsxJfj/amHeAooG04zXWMxunBIDuENFNOUj2Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhk255-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:26:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-949b0d322fcso1379796885a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795811211; x=1796416011;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U+MQls5F39eaWPhjl5MOMa9YQrhfhFVoRGXfaTrSITQ=;
 b=bAXxk9EGOQhob4xJBv2vMTo4bp0q44JIcZxvSVHP/JTVKMAX3+csTimeOsrOVstPn+
 vBPIX/fVoZSSN58135t4LAP2+IxI10bm71UtHEr56zdbNz/ku6PizVS0p9qbHN+n7pcZ
 jmYbXV7Cp7bjbYPlZX4bqpVE66DjlT04tnFZlJJzu3N7uj6I/bdZ9E2Dd5dsm9ZDdgQr
 9Cb+9X1LlDyeA8JfPNYjrwg5VXsVxuF9UTbtD3ZbphArkjJudKaqK8XQCY95hSrIsO20
 8SnHVAd1eTB6yIBNNInJht5+rkW4L9i9LWyL4N4ILib0qvPdPsxLG/F3tMqndpeCypdy
 xqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811211; x=1796416011;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U+MQls5F39eaWPhjl5MOMa9YQrhfhFVoRGXfaTrSITQ=;
 b=b3yvSAePztH0LBPDZkFde5+pG6Ur8MLqPo9TIpd0XWQG81oTVr837cHnJ/Wcc7DYKi
 a6HFWnNAPSabU9SRkLduIc1QsFRd0Z9BvMhFbr+rpE6afpq7PuhQ7AA6Nl42oAD/W8Tz
 kqG2tcfLfPPZjnrUoiQL75j0AuEeouHSSqLD9w3q9KK9p4J7x+NRguVTZFNWiGRtbr/e
 qxnJyzT6MZlVW614vhbTx/Kumbeveb+J9o40iMhhvV4irsCNpH+qEKC9duk30cEPM+ZJ
 kUNXNDPrNZ1dgSkwyqaygPVeS4e1IDpd2E2NGgFydTlAb7BWadXFf56IkeDDxu8YUo2x
 DUdw==
X-Gm-Message-State: APuU4Z/9yX6HtXaMD4jV0U9Hsk8GI4iufjd7e3Cm/7v07B2/fRZQ7yeY
 2AqWQmxECFtTaXky6uTLfkl31lxFas5GcBhM1oCBH/YdHhS4WDtpEOGSedzaDjybIvGE+W6jQYa
 XsJY0JAHMKGzl8eBF/ZeCMLELSyBu8+yTrCyPHgxtQ6WNOZMD1Fti3srjwNzTaxSQvEb6pZA=
X-Gm-Gg: AZFdTZdWqPpxTrx+3YkZwxnsWRqEYs7iBxUkA6NOLS/3LRPDFCMemIENbgYBb0w0LI4
 6+XTrR/7tj601GL0C/hBq7BYMl82GZSD5KzPUYWUpjCb/TEnAHfNJ2IxRfnC3HInbxoGDKXan1Q
 l+VRXu2doeHu5T1JhmhQVP5dM1arl8aMEop2n4MTOdfXkdJGHGHbw8nIy8Yrva/HFfoPqh5Wety
 GfFryu4aoNrsZxH5ZxGjcrTLrcFTzJ+L8usOCKv0ahP1gcCVDic1NtvalxuhaodsfLOtjHBSBz1
 QMjHZKqxHu6lidTfxk5vzlKkjjPq1fBV+LjuoWHePyz+iVVMkr23/EV9j84GNOnC4A2O2YvIfDy
 m5aB1EoHyESzzioqBxBLw6hTAcJJQ+kQ91Jf95UVv54Gl+GBZwodKFas8CID7f0RKxx5tRRcmNU
 nQrHYucDjrGVMbImTBuYrtL7u6Sw3G/hmtmM08wMw//JzWNzCsUrP3U/uOGiSLFg==
X-Received: by 2002:a05:620a:8386:b0:945:d22a:e82 with SMTP id
 af79cd13be357-949ba96e395mr4809349485a.27.1795811210467; 
 Fri, 27 Nov 2026 12:26:50 -0800 (PST)
X-Received: by 2002:a05:620a:8386:b0:945:d22a:e82 with SMTP id
 af79cd13be357-949ba96e395mr4809343285a.27.1795811209895; 
 Fri, 27 Nov 2026 12:26:49 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8044e00dsm69683951fa.3.2026.11.27.12.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:26:48 -0800 (PST)
Date: Fri, 27 Nov 2026 22:26:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, liujianfeng1994@gmail.com
Subject: Re: [PATCH v3] drm/msm/dsi/phy: program PLL_SYSTEM_MUXES on the
 first PHY enable
Message-ID: <oj34ljpmxdycfa6igp7bw7ruk6fuukyxmpnneir66eagrm7itl@czqpnm3r66d4>
References: <20261126052049.1544229-1-xiaqinghuan@mail.ustc.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126052049.1544229-1-xiaqinghuan@mail.ustc.edu.cn>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX5K2NZkeMg0WX
 BiRzfxDZ0nWGazIJrogcQCV22uYO1Zfle5VNVq+NSMzF+Sekaox9gjzaw3V0OTaDmpUZ9tH0nML
 ZGXTDttNGsiQHB99Kwv8n8Fv8lxEAVw=
X-Proofpoint-ORIG-GUID: pserxNNGm1vN27-YZDm8Ys45NZ00r388
X-Proofpoint-GUID: pserxNNGm1vN27-YZDm8Ys45NZ00r388
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b09e78b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JdZ7eC64QEHxXyYvkNAA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX9T34MMkFMit1
 CNpvktQ0gOgCN7xUymsv3SQXU6rN+ailikDOKThPCknTH0j2GcP+RaaC6D+qLkSieSR917b1H6s
 jFxanrjJU+QUklh09u//iivikDzGgN/bk5xnw0p+AbwZgYoFyjiG2/5iRZ0Rsb5U1WRzCTuefPj
 geZT4XSrQAawetWub2G8CBkmsEtJCTa1Q1XbOfQFfUj1ZGmEVHREcmz4jweJ4tghj/xfeze78zn
 uhaB2/6rMJ+NYKBei2iwSGNSlaC8ptVOcelKVcf3mRGosZ1DC9BTF+zdyiFzE8xqmHDsnIKzNxY
 qZvA9mNP70i9Bc3GVu9dYGSaXf9F9a7AMVh7QUNkNVnu0+sDQUzxpEiKYgcC6eoAemSrlsoRPpQ
 5I0eKWCfXKuZnT2lct7qGnR0aJvg+IQ7gLhV3ZEjKC7XCuIYdWW1+j/LRBdoBjACBJLNgGOsKDq
 zxMZKndLcvRkk2zN1Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270081
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

On Thu, Nov 26, 2026 at 01:20:49PM +0800, Qianhui Xu wrote:
> From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
> 
> dsi_7nm_phy_enable() pre-seeds pll_enable_cnt to 1 while de-asserting
> DIGTOP_PWRDN_B and PLL_SHUTDOWNB, and dsi_pll_enable_pll_bias() returns
> early whenever the counter is already non-zero.  On the first PHY
> bring-up the bias helper therefore never reaches its
> PLL_SYSTEM_MUXES = 0xc0 write, and nothing else programs that register
> before the panel is powered up: PLL_SYSTEM_MUXES keeps 0x0, the locked
> PLL outputs are not routed to the lanes, and a panel wired for bonded
> DSI comes up with the backlight on and no image.
> 
> The combination is old.  commit cb55f39bf7b1 ("drm/msm/dsi/phy: Fix
> reading zero as PLL rates when unprepared") introduced both the counter
> and the pre-seed.  commit 93c97bc8d85d ("drm/msm: dsi: fix PLL init in
> bonded mode") briefly dropped the pre-seed, which made the write
> reachable again.  Its revert,
> 
> commit 44784327815b ("Revert "drm/msm: dsi: fix PLL init in bonded mode"")
> 
> restored both sides, so on current master the muxes are once more never
> programmed during the first bring-up.
> 
> Program PLL_SYSTEM_MUXES in dsi_7nm_phy_enable() next to the CTRL_0
> write that powers the PHY up, while the same lock is held.  This only
> adds a register write to a path that already programs CTRL_0: no
> existing write moves, and the counter, the locking and the order of the
> rest of the PHY programming are untouched, so the byte-clock regression
> that led to the revert cannot come back through this path.  The bias
> helper keeps its own write for the paths that raise the counter from
> zero.
> 
> Measured on a Lenovo Y700 Gen4 tablet (SM8750P, bonded dual-DSI CSOT
> PP8807HB1-1 panel, "novatek,nt36536"): without this change
> PLL_SYSTEM_MUXES reads 0x0 at panel bring-up and the panel stays dark;
> with it the register reads back 0xc0, the panel initialises and the DSI
> host starts receiving interrupts (41 in /proc/interrupts, 0 before).
> 
> Fixes: cb55f39bf7b1 ("drm/msm/dsi/phy: Fix reading zero as PLL rates when unprepared")
> Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
> Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> ---

Cc: <stable@vger.kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
