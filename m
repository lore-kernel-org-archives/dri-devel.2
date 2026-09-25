Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DDAC98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F7010FAEA;
	Fri, 25 Sep 2026 14:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BJy/xYTF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQWlPjMm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982D610FAEA
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 14:19:38 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PD4p1E3532115
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 14:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Gs/Zp4Lyis1BUfei8WI1dbDL
 AbMPRkxp7joj1eNb5+8=; b=BJy/xYTFs1C+RCKKuMNXhfxCK8TqLvqP2uymw68K
 GQ1B3ulwMqZu18/z7ZsmtNvYpJGn/LyY3alfnOOvql+Xs0XH95oQRiCp8eOKPy8z
 Jiu4+C3oVlXCrC72+kpSocWr5BdlI/QJOmYT8HQoT5aYy+QeYaEtnGVTAVuQNrnL
 jj1a8Slx8POrx/C1xqZZMnoCBkIAEm0xtJtNXY+QpzlA3ZLfrBzYILNngtzaajG3
 gVYjviAZGlsxd9NUSFGZmw1oR/A0RfmCk1+QxkouzwLWjzavJ4AQ1d4IBThNcig1
 4BNMc3jgzrmqvOwipjHao1JZMvB7lJCkyPnPuCmBf9WQcA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94kbhnc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 14:19:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a1e564fd5so171405885a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790345977; x=1790950777;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gs/Zp4Lyis1BUfei8WI1dbDLAbMPRkxp7joj1eNb5+8=;
 b=KQWlPjMm8dvN5/woZy2QMU/sK2/w2SiOMDEObIWDngK1jTysaobZ+suQdI5o7pl5Z4
 cjy9KJGkE0S5WOpNGYielOxY+ihX2fl7CiC9W6YGOx6WJZLukWEoQNv3RoXla0hR51Ph
 IOsmhfgnkWQRorkuVZD/v63siK7rs9fbG2RxEU3QbA2lD9tnrvuF6/T2vk9L6dp+PQMp
 sgSMZXJ0DOWgIK9U4C0IS4gS41IW+zrR1R6deKtWaSTsaWsN0jmk+/tEK4CA2I68y0Kj
 nCRLe4Cy07/8HEOK3yk63LA505IJaS+8sSSBu3bWzlXZYZuMKYddENBwCaDeyflMqS61
 SJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790345977; x=1790950777;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gs/Zp4Lyis1BUfei8WI1dbDLAbMPRkxp7joj1eNb5+8=;
 b=Hn8RAH0WIlXwuyAPD8+5ZQmzscfDTP3sdsiihj6Y6vYs8sOOWSnKHYmio9ZgtaR5LS
 zVZ93cuLW6xCuDrUESaJHQe+eJzvlIcL2T1athKHt/7l2YtKP5T4lwlrutnKvbrzlAvt
 5fAqEgzNY/VOjrlAjVgghprBVt8y2R81NyK04KBYtJp+hZ/KWiO/+J4UzbN+eHVAu4hS
 0igu+jUuT9SlJ52WHXLjOYpxR2nbgQ99pi2BFMr5ZEqAXnDH2CzBPs56TPzeYg/75UZo
 gC68sWn8CWsg1KCoBP32UfHYkqcURVCycFuHPTAqHp/2geBNY4gEEb91rg8Bp8d8Lgm8
 qAlg==
X-Forwarded-Encrypted: i=1;
 AKwUvByjvR/xRcASVLkbdhrMKKIMMKDu0QUxdH/qwESO8xBfnkwLeHyo6nKiTWilOIPOSSFrdf9jT6UGKQ8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kdX8YpgOkXqFWBzEEfH9kbsPm5PNclHwwmLW6Moc0NLXwhdMvB
 Ey2rce/C8kwvXFO/1LXIgaR3i/KYnmev1TlWLnDy4z/cujkyiMkh2fr9ClscVKmi23tjgV+lFZb
 8YM9nqq09c1BGvpus/93Q4WMU4Kn70ItSjwYY5DkKc03XpcfKw/1xdUZ1lfh4lOw9zckdwaM=
X-Gm-Gg: AYBFou10/fy8rl9L77jdXv2lhTJ6tH7ZnHeEkbRe23Wxn+71W26y7tjWmehGocy6joG
 RAfoNAhoQxmJSmVDT3oH48K5s20Y3GPIr8FRe+OATrGShuFNc3eGQv3eedf6sMBFzMlZTirszVE
 ajf3WdnfzwYpwK+qhPVq0BUMdCaEvSqhzxUzFAqo/Iu4vhN8ok3sc+vR+312CpY562hQeYW3gFl
 9D2FaMS952MyjVpUeejaKY88APfl8quOl1DGI+JIzeuYbjJfrJ3Q6hHqFo+CgO/DMhsiLM17Iuu
 xILYujVhvGch/wDgFMl5mll3xcbJW7iXFx6iax3IY0h3B+xEh3C5eyKAPsHqivfDI+i6FGRwn7D
 leE8/6IBdPw5sndlZulIJQhpjZGKEveiKXnZimhR0+wjnUmF0Nk5q7bEVbX9i4auvZplCtMSZlA
 ar2jx4uINvi2Pi
X-Received: by 2002:a05:620a:710d:b0:93b:ca79:3b0b with SMTP id
 af79cd13be357-93c43be5048mr477718985a.24.1790345976478; 
 Fri, 25 Sep 2026 07:19:36 -0700 (PDT)
X-Received: by 2002:a05:620a:710d:b0:93b:ca79:3b0b with SMTP id
 af79cd13be357-93c43be5048mr477713385a.24.1790345975854; 
 Fri, 25 Sep 2026 07:19:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8e6b0795bsm567008e87.64.2026.09.25.07.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 07:19:34 -0700 (PDT)
Date: Fri, 25 Sep 2026 17:19:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Marek <jonathan@marek.ca>, Val Packett <val@packett.cool>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dsi/phy: power up the digital top before
 starting the 7nm PLL
Message-ID: <hqdsikuu7tgbkchteduzgno3pvzvhxahdrv52qy2v35qj3w7ms@qhsy2cot4uuy>
References: <20260924-dsi-7nm-pll-digtop-v1-1-c2b24c8e218d@oss.qualcomm.com>
 <DLNL4OAG2D1L.2EI2N80LMZV8N@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLNL4OAG2D1L.2EI2N80LMZV8N@fairphone.com>
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab682f9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=BDs8z1iCgLwJFp4fgFUA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: HKlXM9Kl3SjnC3oEK3WYW6obkdmXXggA
X-Proofpoint-ORIG-GUID: HKlXM9Kl3SjnC3oEK3WYW6obkdmXXggA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NyBTYWx0ZWRfX8uhUxgW2MwUK
 WDp3ZK3jcodnP90ogMSqbG+hi/pHoDNpJeIcGZ4SuVxn2hmQ2w485HqPJbbtn5IKwQ2CDtk0h/y
 TqX4P3AQcaeI3rJRnvDW+uHBjp5178FCd3siTMBIrjweoFGNjjTtCwR8CqNlt8u/NCv9cQZe33C
 8DxogLyCuoOxxc7MyL/Wjkpht9wybCMMK/+zh9HtZ9YUHKZouVHBTd7NqUGqjyK5gLOAwYIMLxE
 vsUZbcJb2GgJE62bCmZWR3ibu/pXLYW6Wkjtk6pI/rm03mgUayHewRycJVhGp4UDHL8Dq0Ku6TJ
 fz3jVwW89u9lUl7EklsJnAFJrokM7iKAwyp0b+G3UMdMfhCrkuLRYr2wfXoGnIe0X3lILbhL0wF
 +QihO5wmU7DrKJIEZcYZ4HCxwz4uBABm+qLI84G92ZDZQ49WoSxDusg3uWz0Fmusx89G+uRCt4N
 A/EqSJ83R3eukDi4flg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NyBTYWx0ZWRfXziK8JgH7BuNe
 IucKOkGBvjf8UMQbS/OTAgp+scBnwUApRiyGfy3JWR2uHK2hkZn46czqKumtACpbIq5I5v7t5tY
 UP5jFKzfUC0ngRntsoLLyGqNpiaHNwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250057
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

On Thu, Sep 24, 2026 at 03:36:05PM +0200, Luca Weiss wrote:
> Hi Dmitry,
> 
> On Thu Sep 24, 2026 at 2:51 AM CEST, Dmitry Baryshkov wrote:
> > dsi_pll_7nm_vco_prepare() de-asserts PLL_SHUTDOWNB and starts the PLL,
> > but leaves the PHY digital top powered down; only dsi_7nm_phy_enable()
> > sets DIGTOP_PWRDN_B.  The PLL cannot lock in that state.  This went
> > unnoticed for as long as the PLL was only ever prepared from the DSI
> > host's enable path, after the PHY had been enabled.
> >
> > Since commit acf7a91d0b0e ("clk: qcom: dispcc-sm8250: Enable parents for
> > pixel clocks") the clock framework enables the PHY PLL on its own while
> > applying the DT's assigned-clock-parents from of_clk_set_defaults(), at
> > probe time, before the PHY has been touched.  The lock fails, the failed
> > enable leaves the pixel clock with an unbalanced enable count, and the
> > retries on every probe attempt stall the boot for tens of seconds:
> >
> >   DSI PLL(0) lock failed, status=0x00000000
> >   PLL(0) lock failed
> >   dsi0_phy_pll_out_dsiclk already disabled
> >   WARNING: drivers/clk/clk.c:1188 at clk_core_disable+0x244/0x24c
> >    clk_core_disable
> >    __clk_set_parent_after
> >    clk_core_set_parent_nolock
> >    clk_set_parent
> >    of_clk_set_defaults
> >    platform_probe
> >
> > CMN_CTRL_0 reads 0x20 at the failing attempt: PLL_SHUTDOWNB set,
> > DIGTOP_PWRDN_B clear.  Setting DIGTOP_PWRDN_B alone makes the same PLL
> > lock, with no rate change and no other register touched.
> >
> > Power up the digital top together with the PLL bias, and power it down
> > again with it.  The normal enable path is unaffected: dsi_7nm_phy_enable()
> > holds the bias reference and writes CMN_CTRL_0 in full anyway.
> 
> FWIW the same fix seems to help on the 10nm with this error on bootup
> 
> [    0.503085] msm_dsi_phy ae94400.phy: [drm:dsi_pll_10nm_vco_prepare] *ERROR* DSI PLL(0) lock failed, status=0x00000000
> [    0.503168] msm_dsi_phy ae94400.phy: [drm:dsi_pll_10nm_vco_prepare] *ERROR* PLL(0) lock failed
> 
> I've also ported more commits from 7nm to 10nm locally, will send them
> soon, since anyway they should be good fixes and code quality
> improvements
> 
> drm/msm/dsi_phy_10nm: Protect PHY_CMN_CLK_CFG0 updated from driver side
> drm/msm/dsi_phy_10nm: Protect PHY_CMN_CLK_CFG1 against clock driver
> drm/msm/dsi_phy_10nm: Do not overwite PHY_CMN_CLK_CFG1 when choosing bitclk source
> drm/msm/dsi_phy_10nm: Define PHY_CMN_CLK_CFG[01] bitfields and simplify saving
> drm/msm/dsi_phy_10nm: Define PHY_CMN_CTRL_0 bitfields
> drm/msm/dsi_phy_10nm: Fix reading zero as PLL rates when unprepared
> 
> Unfortunately some other warnings/errors still persist on bootup that I
> can't figure out... maybe you have some idea?
> 
> If not, I don't want to bring this thread too much offtopic :)
> 
> [    1.197104] ------------[ cut here ]------------
> [    1.197113] dsi0_pll_bit_clk: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set

This looks like the read from the unpowered PLL block. Check that all
required bits are set. It might be worth replacing this standard
clk_divider (and the one in 7nm) with the special version that doesn't
go to the registers if the PHY is unpowered.

> [    1.197134] WARNING: drivers/clk/clk-divider.c:145 at divider_recalc_rate+0xac/0xd4, CPU#0: kworker/u32:0/12
> [    1.197150] Modules linked in:
> [    1.197160] CPU: 0 UID: 0 PID: 12 Comm: kworker/u32:0 Not tainted 7.2.0-00088-gddc402c24fff #86 PREEMPTLAZY 

-- 
With best wishes
Dmitry
