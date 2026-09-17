Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88337C982C1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 02:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81DD210E0FF;
	Thu, 17 Sep 2026 02:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oNt7axBK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gQdWVxZp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DDB810E0FF
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 02:15:13 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H1DIws210481
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 02:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0nkxLnWGJPKpLZVwfcJxb6ow
 WJd+MOMDPY4c/u0ORDU=; b=oNt7axBKVncjEHFcBh7gJPyYy0nDVJrzEWF2NHRO
 //10oKhbUh+MxVooNlTmJTI4FXkKAAZr94XsRInA0sks0QOa5kCSXEZGPLN6Cjr3
 F1w7lFS9dAABj1wPoRKUil2E6LDvFoUVh/6Co/rlRsLjiDlsOKkH7mXLbN9Xhk2h
 /CTjVTAH7cCjiVui2nSSLKEu4tIWFOwdrxuwtum7aOKdA57uBlUpnFS+yz4R4ib/
 hX1XgKVoxAhqmvVAZ5jwrDH483+tKTu9iPWcHQKygMHp3N5nDjUeHJow5/Rv2k7q
 nsbplCiHZLXTWaG2sFGnVy5H7/JoLGJgNS9gLu9LqrnqhA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqxw8t3u9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 02:15:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca8aee88725so452620a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789611307; x=1790216107;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0nkxLnWGJPKpLZVwfcJxb6owWJd+MOMDPY4c/u0ORDU=;
 b=gQdWVxZpp4dauaDr1GrKj7sVMuTVHvpMg29XATg67mrNW2iVaLgjyaO2lVAPy4596d
 IUivzLCoGQ/bS6shds8qvms+pqlDca17mc0+aSjtfYB24SDK8qBr3sj9WpAWqwIKqXxd
 GfKYKymymmUTwGQViaoGYsCn2Qs3z9SN/Ds/1mSQQbFDaGyit9IMMFfRmtrGH1a+NSCD
 gP/pbjGUrQQLPD8NPbQnJyqjVmRgNRCfJvYFsaVwoPPq95u5H6r36Ty7n36L3YrFe+03
 k918C473KL/SsOcYyeS69/w3x2SkyNn/EanEE8SzG3mKbhwUNEtWnqFF+HQcsr7EADj4
 qE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789611307; x=1790216107;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0nkxLnWGJPKpLZVwfcJxb6owWJd+MOMDPY4c/u0ORDU=;
 b=VoFpTlsk6nmcgqGOwYASv50e7GxP3VzmQV+b28an4npUt4NINjAwiLsig7wt947jfp
 GuSal8XrRwy/wJEvAOfOyj1ba6iB77Ai/P/C7kg3Y3SZVErMhlTxwkz6cNmgRy4hE03w
 aLy1pGNOk5CLpkr0SKQj1uooD5roSpGXB4PQMsfLnfDOVxIKJIwV21Tnao1vaTGl2oPZ
 pAwwHKaJVSVCjtSIlyd2A+3OpWrlfGHCEP3MEt+fL8UTAAictPvkVz3HpMGHbsF0wbvI
 PCQq1MosjysfiiFft7xQ0pCFq+RNPxC2ThZBYYIYJJazEfQxDrDYMn0Si5aGIGUlYIIw
 gpqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTxTAI/BKZYyltvdIsUKdcmQWjcU8TA2vhSOO8YudYiFSgsEQPxbD/3liXchdf6XSwGmPQoUxMTDk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nIMh4IbYUBYGJ+5ZiZMa9fY+/InURUXVu+5creFRk35vH+iGjg
 ZDWChuiKshvL0lbg1b0rGyRTO5Y6MIKqnvIc0Tco5ScdnSl9XdOFwdeJdM8KAfI2U3liOMsi5Uy
 REwQQ9YTG5m/keERpHB4DXK/pei31Zb7t+B8FkQGYSVn9hT4dNl6s/kXCAmeTcEVhlh6h+kk=
X-Gm-Gg: AYBFou1S0yS7NZkQz9O7WB+vl3t2IyvayWCmGrsP2Mt3A/OBGMzp48ttQdS1Gb447fT
 0u0SoClJKzGW9teQDyfdxvBFeRnzjhs1A8AdmeK+5Bv0dLGu/+YQ/dDNFy1lvpKT4CYonyNQ6t7
 gwrcjFmE4HXgmFbXPM/obDoggpeACVoQXvUuj2z+++wnOOnO/ocBjKqhAPgfxvZDtHjHZEvVIJ9
 4QF62ELwxyaggaDlXYqRRDcUESLPfFDcn0BJk+eivQ3ene25+p+dNUMfXpDQvpk1+a/LqGDc9Hz
 40FsXDHi7K+sjeiwSkJmEqz47rZ3SAcgKxPzOdZU+X5SA9w/6l17i+qfDwrHhuP9z6JkEN3mnXB
 QydINB4fBQRiT4hai6f8lKiR/8SpR+yKRC1MCMIQjInU=
X-Received: by 2002:a17:90a:f09:b0:39e:218c:d47c with SMTP id
 98e67ed59e1d1-39e218cd674mr8456840a91.9.1789611306699; 
 Wed, 16 Sep 2026 19:15:06 -0700 (PDT)
X-Received: by 2002:a17:90a:f09:b0:39e:218c:d47c with SMTP id
 98e67ed59e1d1-39e218cd674mr8456782a91.9.1789611306226; 
 Wed, 16 Sep 2026 19:15:06 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bfb19f8cesm14368985eec.2.2026.09.16.19.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 19:15:05 -0700 (PDT)
Date: Thu, 17 Sep 2026 10:14:56 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Nabige Aala <nabige.aala@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Subject: Re: [PATCH 00/17] Add Qualcomm Nord display and eDP PHY support
Message-ID: <aqtNIFXY2OcL3SPB@QCOM-aGQu4IUr3Y>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
X-Proofpoint-GUID: NM_zjd4jOgBTCEz5OnDZWBJUJBvcnJWS
X-Authority-Analysis: v=2.4 cv=bY3+w+PB c=1 sm=1 tr=0 ts=6aab4d30 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=NcJHP3AOhwWrRdeD_j4A:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDAyOSBTYWx0ZWRfX8bYzNRK5eYRj
 A527fomdzoLWR0PNEWDx51zuKyIX1C4YZ+Y1PLm37t8HP2m1yEa4AU4eSv1ICjPse6jWjjWfAdO
 j11EX5fQgi42MXiQZujk2wkUPJtKQDw=
X-Proofpoint-ORIG-GUID: NM_zjd4jOgBTCEz5OnDZWBJUJBvcnJWS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDAyOSBTYWx0ZWRfX2Z/ct0nOu5SL
 0oYntBOvz5Y20YkyntZJzH2iEce2cpvFvDjFmX8HOgplukbofHf7PHF88zDx86GjJaaGZef/vtM
 eybuXdIV2KZYw4u4pQ0CCE7hjYM4hDfBbDfr4AZbP4kZpk+1przFIaI/pLZJey5dN6JooSBBRg+
 QPyb0xaGNmV9iQ4htLHenpMrhZDZlpLk8xRsdIL9TyrIUliG/21dhONcVKCywF3SVrS9WBEddjX
 h2c8r8buKmNQtszAF58SEAUP0e6xnPxiqI6xqkv9HjqWPvFz+5n5ZJuhSmn3X6pLg2VHePWKZvs
 KTse/cvaQ/V1aC704LtmkWbmQ7Pdzqi0iLb2sLEFBHFMmMvejjzaY9tCGf74jivlH6DmAJPijvJ
 dTvjTr20LB0XM6JRbqpi4p2N9jaEUS3lk9eCiS8dqvfFHRahEHj1sMED1LeLwltzg+oHVre5Eid
 O1CT7HCVVzanwOnRLxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170029
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

On Fri, Sep 11, 2026 at 09:06:31PM +0530, Nabige Aala wrote:
> Nord is a Qualcomm SoC with a DP-only display subsystem
> (MDSS 12.1 / DPU 1499A) and two independent DP controllers
> backed by eDP PHY.  The PHY uses a different register layout,
> PLL/SSC coefficients and TX signal parameters compared to
> all existing SoCs supported by the qcom-edp driver.
> 
> This series enables the display pipeline on Nord by adding
> DT bindings for the MDSS, DP controller and eDP PHY, DPU
> catalog and driver entries for MDSS and DP, and full eDP
> PHY support.
> 
> Tested on Nord Ride SX board with one DPU. Both MDSS and
> DP controllers probe cleanly and panels render correctly.
> 
> Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>

Hi Nabige,

May I ask to be copied on Nord related patches? Thanks!

Shawn
