Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DFACD8C8C
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C979210E694;
	Sun,  7 Jun 2026 21:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FNKCdJuZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d9SOPRo1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E6210E694
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:55:11 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657El9V5443064
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 21:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=4OGc3jEMT7ZP6mQqSI1cOL/G
 1ZjfZWPKtiL7dzICldU=; b=FNKCdJuZBdytcKuzX8grLCyzWIYxtAWCidcdFGbC
 L8hz+seOzQ0MS8T5hmeD4m9Cw9/aWpQIchkgWGjC83SO4TftIb4dGrlNy9uYBqD2
 B8lrcpF05qpcC2Bmn3BCmFf24XpVBgwJkJ6F5oXEdEAcPz6oEeMoNlX6M4MvE/Ex
 iVPVioUzahkDWMIsGz7aC2i3XfvlJ/EKU41qXNB+EY9y+JCQ4jQmqHaioeMLx8V7
 7gNGUcLDqNZm1GrIeII4pwaJoHz7gyitqxAvUSZVmBIuEZCUrmjzen4BWulMUxPA
 VTLjU4+GLCj4JYPVIZxq0A8DvTGj4j7vSt0hb9CoSc8O7A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1cr73-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:55:11 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5b344b4e8a8so724900e0c.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780869310; x=1781474110;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4OGc3jEMT7ZP6mQqSI1cOL/G1ZjfZWPKtiL7dzICldU=;
 b=d9SOPRo1Vpi0hQzC4TMvbuAFI84mk/xVqb3hwlzBtDd8tk/vpz51/kAiu3AjWRRsfw
 7bqojSJ7vzwb+LgBQu15OzsAsbmB1jkkT0Mf3Vdr6WRoQ2mI2vTCXrWlCWVjt0kFOGgP
 gnDPi24x95zpAY9zfcQPKSHjX+8vXgKsfRrF6g/pwgEx3JEDeElJjSt1NkMJ9XilkBkq
 k6ZSxyE3EwngaRFUkFBQFexbqbTTHI1JeV9VH1UxZeICPxP2AlgM03idzgBv6y2gZPWX
 ifHra3/lSXKVAJqPGGUG4hBiOm2zeRdWl9kYaMX5iN8SwGxIPmyRf0l40XzE38sq+R91
 Szlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780869310; x=1781474110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OGc3jEMT7ZP6mQqSI1cOL/G1ZjfZWPKtiL7dzICldU=;
 b=Si8CWsuWo42s7l0eTuwEpk5WjPomomp3xON4iRT5gquDG4n0mZ3DHIQcNhWBFKsXiJ
 FZvn+SFsl4LVUycNJcneGNnxBi1tOQNFT/qH6FMxB+3OIaIBj52Bih/g+cXJ9SUyBV4o
 jLDtL3/prfopQtCd/mYtT/+GbRwqGcMEf/0ukvlLtaYmpdW9Ki0KU5bjuxLgVU9MDLzD
 JtwzObfq6IBUiai6bo6/d05ciAGSbRoojIOdDzc0bLxeJ07Hy8SDQ8QaeCI0JDfrOCCj
 0NLhrvmjxsd92hhcTo1LlKzN+yM23rUukmnRZyZliO5NQB5kUTSw+FdPrBes/WgpXpp1
 8RNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HTC0ts1NqvcceKysdQybsYfB0+pKRO3EpLLKf/gC43sIsUEj3sbHGUUqgA2Z8/NADyBtfQRQlwBY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyPoLmh6+vnebhlyzn/w4+wJHqAtENakr92/Nq509UON5b7hdK
 FVQ4fqHW12V3FrsO9ZAdgupDf2eB1LqyG6OSeHBPAi5iPr/8Y+P7vIxajyv8LC2UzUOImrFMWNJ
 iF5QMOWkjAEQSq90toHJXTIDvsumTEoTICDgWBeoKuXbOFVyXYgtAziVyUgOakYH/mD8nM6M=
X-Gm-Gg: Acq92OHvZEwn0Pnh4AR0TwKp13+eYLOPEf3hpIyTxHzuxCCc+3vpHL9n25w4x9hT8IA
 RCPXkQZ9JlvXmUX9koMWCvW6mFXpmH01t7klO7HqsFxhTXs5lNy0kTVpJJ32Sf1b1W2yt7GJ9zr
 BEwY12KHSQWuCrswyL4ar7+esEwjDQHvnzjGRyxYu6WtRaqcA9G33HfvEnbPgC1gZe+pyJYxvmK
 eYhSoOzjF12hJpV/1U75R0JNBvrt+a9xpSsgHSFl2cPv3eYKQMVzw4QxbWgBbRMMXLrFB/nwVMD
 oT4MAZN163CN6l93wnp3ZBkMiH+GyQdESUd1fEB2G14cbAWUjpMD3xFS2UmQutYcjD3pvQcDO4S
 eFRpqNXauYnrn2N9A+4RRt2wbAW/mLBNktfoiC9ReyEkwaBp1RyTGjw9NKCPEyn3bM9RqXzZQMc
 jinm5ioZuGayK3NTt9ikmeALIJZt2ymaZpp/q9iwuNMv0wrg==
X-Received: by 2002:a05:6123:a1:b0:575:634a:a604 with SMTP id
 71dfb90a1353d-5ac548400b7mr6178620e0c.6.1780869310369; 
 Sun, 07 Jun 2026 14:55:10 -0700 (PDT)
X-Received: by 2002:a05:6123:a1:b0:575:634a:a604 with SMTP id
 71dfb90a1353d-5ac548400b7mr6178612e0c.6.1780869309948; 
 Sun, 07 Jun 2026 14:55:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa7b9868afsm3368954e87.59.2026.06.07.14.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 14:55:08 -0700 (PDT)
Date: Mon, 8 Jun 2026 00:55:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 8/8] usb: typec: ucsi: huawei-gaokun: pass down
 HPD_IRQ events
Message-ID: <qvxtodvp6zqeohrb36kjxrglkk4rx3gohrx7uvz2x7zm5fxlyp@t7d25j2pm6le>
References: <20260608-hpd-irq-events-v4-8-30b62b335487@oss.qualcomm.com>
 <20260607214621.9586A1F00893@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607214621.9586A1F00893@smtp.kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIyMCBTYWx0ZWRfX6tpgkzbxUNad
 LuEc6f98dvgFSrOGlmL28Kq8okod2AYPXx5UO6Oj3aznb1UedKt5LQFqxWNNvH6+IjVqHN9DrI8
 Fj61mtdAcn8F34DzJjgqJWl2Y7iUlDi5x6Gk42gb9mCMxi8XtyJWHwvdwYG1/+3BjoFil0dP79n
 h3wCi9hrXeQ/z8FUS7fLoVBXRk4aAJYSCvLw0D/6tsiUckaHyJPwfZzLNmhil5eJOlEiN6wMxJx
 tPUc3jMK9jOVY4ItBoRMnxtQKssrso40yEnRdAEk/aALvnjDkWNbsEKoCFIjqXEMWuFC5KY3Vp5
 nvSZUd8cOIo3If1hUoBYvchS85pphn5pkhc8bhVuze3diyrF5HZXgsUmA2dq4Z7ZbFuZROlG/ko
 dKOOIFLiOfRgqTxIBuXNI2+Fk7Y1iBnkpcQNtz//i3ZCQqHIu2eWb4+GbBMv4AlLg+Q+78TjyBL
 lhzuIZOTno5VQpMbbJQ==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a25e8bf cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=aFa75qVXnfFcn4bRmZYA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: PsEc4waqKyFM3DbOuy86aIg9Aq4WZyky
X-Proofpoint-GUID: PsEc4waqKyFM3DbOuy86aIg9Aq4WZyky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606070220
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

On Sun, Jun 07, 2026 at 09:46:21PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Early return misses EC hardware acknowledgement, potentially causing an interrupt storm.
> - [High] Deadlock between EC threaded IRQ handler and UCSI notifier causing inevitable timeout.
> - [High] Out-of-bounds array access due to dynamic `num_ports` update surpassing allocated size.
> - [Medium] Undefined Behavior due to shift operation with negative exponent.
> --

Pengyu Luo, is this something that is worth fixing? I don't have the hw,
so I can't check...

-- 
With best wishes
Dmitry
