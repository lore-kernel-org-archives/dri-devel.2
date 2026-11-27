Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21D606A336
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=opzmeyBk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j8N678rm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1573910EA19;
	Fri, 27 Nov 2026 20:33:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A436510EA19
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:32:59 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJRtPB1381876
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RdbGxG6smopZOWzLypq/6hlFg6tVOfBxaUqDNkzkyXk=; b=opzmeyBkNRaTl6Ip
 vhb8AXh7xDbxZjFujumTPew5ZdjDSgWczgXMZ6P/fkbwsBRocrkAhbRbLFw93LWc
 ZQc6dtb2704fOdLQM1IlRnNk6FQhg2OY6y1UP3hA1iKTvAQ6UCd3kbhBAbBcqoHJ
 Oke2YxFTSXrc2zlgBFk1kB8FDPnY1V3aWxF0soS6meoxuEO8sVVqDq2nhoW/Xwkw
 q30c6AuR7CHjzt7YG28ioP3EKAL8zbNsjN7iYVj1BRU8Rm5RXQFkCfWSA758f3Uu
 Zrn18arN+XsUwkTjKn5bFU2BoZIknSL4PFql3w3IecpHTa7NCG5nv4mbjzuw4JFf
 pQzFQQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g1s84cg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:32:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so1449927185a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795811578; x=1796416378;
 darn=lists.freedesktop.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RdbGxG6smopZOWzLypq/6hlFg6tVOfBxaUqDNkzkyXk=;
 b=j8N678rmvpHKuUYGRaIoGFpRjVqUzvJfzTBonlQyH8QMW1Izjmz0VSn8kdfZL4Pgdq
 Bg793F8gxItTklo8vNXYiokyIqFIYMOY23SMJEQwzjZ8T+2mTiMgY7n6nLgIZbvsZBW7
 U0jk9oBycWnapCSMlZTrrdMTqkOb97IMJNpXb5rgNh12ODcovPIi/slSCXzOod4cUbM4
 n7MjzT0rdwhv/HP7eSrF1K7GZXWzuu507oLDxQfVtcQ/1o1kksNe8NwDPki//Sb3JoTZ
 X1Njljj2ndhzBVZXrNu1CmJ9E2YgkeJM0elVzrAVNd3573+CCf2e2BMuhc8/lAGqlV7f
 wgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811578; x=1796416378;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RdbGxG6smopZOWzLypq/6hlFg6tVOfBxaUqDNkzkyXk=;
 b=SePE+ScezbWSYvHxgElm0yBpCWZPMw/OnInmgbcSsIjDnI5CcqoLjTLtNBf6i75L2k
 mNXppa2A42yMzlr/uGaweV1ZGzAGaowK9a9GPc058xLacQ4wQQ5vPSCcoK7aVkCyv0+6
 KrTPuJFCCjboajaxP58ADXeZdAO+WdZS4w6vbaHTomwNjQKlWidb1OXoAr8OtCTWoUrT
 pp3tZceS2qXP/TGmi6unVw7+ziQIN/n3u/CXpfWERRBvsAut6hYOqLNJi8cdejhS/oMX
 mBscHaYTnI5644vjvYOwIaOC3EtcBmbk6QjyHaGvujtW23HVo9VTRsY/ov16vM0mPt84
 KQ2Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHoDaL6IMqPdj91TKwkMFCoTB+IXk2bkL7Bo09wLelMjkP+BNNO+fP3vGX4RCerHq+FomyRX7IODZk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+NS1+elFfZ/CYS7EjrCssQqpvSTN3t+4BlUbBddCLuFTojMe10
 G51sU8hmMUhFOywR/FtY0EHnHkfae9WGQsk4jKsNgrOcaS1e2UDdUEHrS9nyQxL3y8n3x7/7aSn
 GrkHpTmIUnc4SVqXHUqgME5O6ND5CwY8nhz4c9JSzUJzMNPtaEXpx2uXg4hjKJZ2aTSOg8sE=
X-Gm-Gg: AZFdTZenRNHz4BVExgAuJ9fGdE/83DZC4ygFwCr0ykLXRtI3UH4jlHFMyGyhliVEX5Z
 9w7/A33CrFkW2lXG/uAYvHzLaZSnlydxXmlOI6AzIcT+cG/jU1yB/3bMIIO9XVwU5RHRqDR6Kk0
 O/y7X8NcNjKpAxAfcnskewVrhoykikd12Isuxcr26csYQ8iYfa/3NSu8KU3qWkvwOun0FYGuV06
 JAw+P9bhu7eetGUEJfusuQMo7nW0QFiAqNOm6OWJf7YpVWQzJsNm9rA3fK5kCp5FwN8jXFJnCFt
 MCLhilUKQrPczCku8BNaisXF2aXgRW5BbPjyui1HsnyNDFSqk0QdD29CjuUTS25vwD42Ddx+62A
 3/vKwd15ClLg0KCivTVvuTUjy/8Lep7MemLhvDgcxprtZB4X5j3LrJo7JkeiDNA==
X-Received: by 2002:a05:620a:28d5:b0:949:6d4d:2396 with SMTP id
 af79cd13be357-949ba9c6ac4mr4407928785a.27.1795811577985; 
 Fri, 27 Nov 2026 12:32:57 -0800 (PST)
X-Received: by 2002:a05:620a:28d5:b0:949:6d4d:2396 with SMTP id
 af79cd13be357-949ba9c6ac4mr4407922285a.27.1795811577441; 
 Fri, 27 Nov 2026 12:32:57 -0800 (PST)
Received: from localhost ([2a00:23c4:e5c9:901:c496:8838:86d0:bc8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849e598sm709585635e9.8.2026.11.27.12.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:32:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 0/4] arm64: dts: qcom: Add support for Radxa Dragon Q8B
From: Christopher Obbard <chris.obbard@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Linus Walleij <linusw@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
 dragon@radxa.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Daniele Briguglio <hello@superkali.me>
In-Reply-To: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
References: <20261029-q8b-dts-v4-0-e8e7438f5545@radxa.com>
Date: Fri, 27 Nov 2026 20:32:48 +0000
Message-Id: <179581156894.3905807.8399699622838832226.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=364;
 i=chris.obbard@oss.qualcomm.com; h=from:subject:message-id;
 bh=uTOlrKK3r5wHlu4GNa7hytHvMz4ce38/J/1xbEGeX68=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBrCejzTK0vY8gwlDXzGRSZrdDk2sadJ0Wm183Rv
 cxZQ1XiJSuJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCawno8wAKCRBjTcTwaHBG
 +AxYD/9UsZNT7/FLc955HpspGxAIsT9gvOm/npB6eyd1uICYgQQa5CMdp03G7hw6lorCfcHe5BM
 A3gtWHV+8rfD+AVTMvNdEimJwVR+bQ6Jv5+SoXxZRbw6Dhjvuk5JeDjQCYPSJx8OkQlwe4j3g9O
 4JgPJeSThp0kFksAAjHOVrbxWmekg0WR45tsFX5+fzemIlOxNguBPxtLDzoRFV5jV9+uhlGjUs7
 PU4G/f9h2+t5PZIBoJ89CvaCzh1mRl0eXDXz0q77PYyPYoIlHMXeDADxgvFMCgN0+GXR2g+IBLf
 supvMhGyrT4ItRqqRU9nl3Pu/xMLNMdegq4kKRNCPRRYvDC+jci4KSBTAHx93tA1pJKT8byI3aq
 0KBC/IHH+xt03QLOOxCMsaRI/ZX/NcTYo+1AgVnaD3m/3DY1hYC1QLMlQgja3Va7F5Egnwky5Uy
 4LLp80n4YpNrpMiKMoiJK1ubZwRlhso0hN7j6gUXjJFCmF4FWpj7oydhXyMrsSS55NdiPwjurj/
 zXHmsq8moGAE98cGq7IxHI/Q0Tw632ztNsQVEH93jo1EVNIkZw4ZvHMmGxf5lzo9Viu9xf7Kf7z
 J9Nbuj9ILpohAHYi1FVAI8gQDGZ1eFDGJEviLW6Oe/jCbGtp1KvfD/VR9gcRP7PKO3YtKkMyMcC
 pLsFwktxzCIc4VQ==
X-Developer-Key: i=chris.obbard@oss.qualcomm.com; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8
X-Authority-Analysis: v=2.4 cv=FYOiV5+6 c=1 sm=1 tr=0 ts=6b09e8fb cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=ksxQWNrZAAAA:8
 a=EUspDBNiAAAA:8 a=bUWDG7REKp_wvTPU5MMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-GUID: sNMRbVBpkCky8GWGWFJ-oWoTj6ktX7V5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX+UEGLSFnVGCr
 zYP6Q92OIRP6feZMErpF9uXF6aQvhK1XxQnl7Zc5sXm+2GbtgPYWrj74DV1BGiX5NRLRyGPe59i
 dFBBvJWqySSlF8IbmRAVdLL42elU8GUD/Q+UZ++UFJpnT+N1f9bQ8J8bB+NFLDAcj96huOHAbN5
 CrJWRoKkwsPYy05C3c2EWCckZ2ZsUw+JwL9vymgKZsWc9R87EVTSqC795SdbI/4pLxXk+ALUyFa
 vtJl8fU7p0xWwDOTkDtDE7WFVo1ZSDhU0NovXLDxOFZ1CZGmwOsomLmZH3wqQQX17rbtYdc1g5H
 9wDniZ6VXCvoD+lC0fUZTIiW3+iaZGY9YWzpz9zkP9Lnps6CsZkkxMmvd3oUW6OSL+8F61wZl7B
 xebaP14PNYwb8j/dMZdETf7ZVqO2z06F/jcdnxO8htwim/HVhrG2ld1On2abF4tRhkjpK9KcSrf
 0m00O9jE97Gtx0uTyYw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfX5CjdqFMRbOcf
 tPyupisi+KbfL/vQMINuuhYqa44X0misG6dq8MtsczKm84LZFLM9OFhV40FNJdM0RuaUIyNwLNK
 +BkXI27EPkL2yehzdZ4wU0n1erMyAtE=
X-Proofpoint-ORIG-GUID: sNMRbVBpkCky8GWGWFJ-oWoTj6ktX7V5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 18:13:34 +0800, Xilin Wu <sophon@radxa.com> wrote:
> arm64: dts: qcom: Add support for Radxa Dragon Q8B
> 
> Hi,
> 
> The Radxa Dragon Q8B is a single-board computer based on the Qualcomm
> Snapdragon 8cx Gen 3 (SC8280XP) platform.
> 
> [...]

Tested-by: Christopher Obbard <chris.obbard@oss.qualcomm.com>

-- 
Christopher Obbard

