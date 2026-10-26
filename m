Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D23606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WBa5R6DO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZwfIFw0i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38BF510EDC1;
	Mon, 26 Oct 2026 10:20:31 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19CD010EDBB
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:20:19 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q9aRYx2560526
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7FDKcPmUfm8pKhwk0XQXsdGdq3ble75jjcxbCWLT98U=; b=WBa5R6DOTbjnjhg6
 oR+yaDocepQyyKbFvCO8gL6By+UFGT9Xohprkgdmh7jPeGBhZAFyjKNzaOkuOypT
 ygzkq3W3+P2AB2eBq0ri/8gOaObnxIJZbgBCgl7T4MBG7s6FV7bY0VSnSZwv4NF5
 binG9KB7KqKnNomvsStayo0oaocFxa7jCR/BVD064JVSxlhcVi8cKS7vvnu6EY4b
 GSN0Ee60XYevX2wC0LUHkZQfp40FkLpgI0o0Sc4KPoXwqP332NqnWvsKeTPSH/8/
 WX6l2wAtYXEdbplrkbwhypaNUQBMopXZofmInDGYDmvKKslYj1LcLb9bEiebykoC
 v9AuwA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cp85jm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:20:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1e62510cso720699685a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793010017; x=1793614817;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7FDKcPmUfm8pKhwk0XQXsdGdq3ble75jjcxbCWLT98U=;
 b=ZwfIFw0i8z+CY/VD4OHCIDz7TGqef8ZJ+QvWRX9LJ/ir/gqy/ffaZTzWPZkeac2q6K
 gDSWiF6S0/z9gWv22Qt754rHXYRuLvziWeySq1xhf/sQBZ/tW+8rW2FM5HJL0pjgL8C5
 2rRoVFlHBVjNt18hqPtBeA6FtqlhziysS/x7+xVZ9A593/RPHDMe96aBVExjHfxkylDL
 V7fUkq71GJpacQIlHVdDOkHSRhwu47cGxvKCCA6j7XPBouRuJrWXfd/pgPEBCVEY/OR9
 8Xp4nZjbassJiG7KI5pECiEttouYh1kUjipt5v2K81huB9/3Fnf98fgtoMTRha6VX2DD
 M+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793010017; x=1793614817;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7FDKcPmUfm8pKhwk0XQXsdGdq3ble75jjcxbCWLT98U=;
 b=EprrcTdA/2Wk89vl0BolMysLyDcCdf4A6+aK/rqSndPRlbaIh4XIBR/F89yG0my/Sf
 Ph3hEMYXuc7xgGrv6rSy9cpdVoGgbaxvNFgjQck4muj8wqz6CXeYshdNx6QpKBu7+SSX
 OxrIIxAAhgFvrr0ssFM4M6KhdEs8lZii55ZJE9F3ec3W8ldc7ygov8195zHYmDlqETXN
 NmjAgTCrb2QhhVSmaXPVZhGPbm950Fr57z2ywpE7KnSeK51Wbr/Cxh6s5ORHHI9xq0eT
 o/wprPyyGcrVwA/czkeJg71SXeO2CpDqOjp9SSWiNl1JpiVEJonv/4bmQVzFb0e5+enX
 G8tA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4r9QfM830haB8BjAjnOaAurvZCAnptZD/OlG5qN6QDfVqHIeFW6bNQ5ZvF440FKdpkfrGlgBOacQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ2oRUVQ+p8Iv8I80TJWwkPW0Vf5FfrAJgoeETi+0s8+WAhzkqR
 prDT0MJy5Rh9qE8Ba7Ccz2D+rO/AStb9x8oLlzpzfwYtJXznhauBz2Tzj86/KFSCLujw5C5ikQ6
 lvP8DYUdiyXjLscbG1bX1US1T1q7wyUdQNt2oXVm15sQMLKmHwwyS0oo5kxIouTnPmJOMrZ4=
X-Gm-Gg: AYBFou2PS4iDgOpZcpP3PmPwanZPzd59wQYZH1IjdBQwhe3Nsgb4JpUEhWGidtc6AYR
 EsOLMAWMV2lV9GWMMB8ssSjTKbzjWBiQpaK6ppH/3omJGQLohFpOTw2Lfl02mFElzk5gbnLSwj8
 T3Z7BRwv75vKQzJsGvaLpxPBeDdQYM7G8hP/eWrBJy6YBofKVMshguMksHAkDBDq5nmSfuev27N
 HQv84XpFSmOLskGYTDCpOAxTRDZJekF+wTLlwgjDaHCoe64TNFRoOJXr+6279TeRcSH3FpT/R57
 Lbsd+IakoIwngo0IT4B/8FzNZfHs8ezXU9lq/6/XBamCVJnli1+O3X5LTx7xKxodhkPST3f27lN
 4jSPKwbQ8MIousZXfXX2p7a6cRZubpsoojNmKe4lmbOetkYaWW/lP+DtS6pMekAXxZIcJbWK1LM
 lpKhz6McV51nvT
X-Received: by 2002:a05:620a:4002:b0:93e:910c:5fbd with SMTP id
 af79cd13be357-940ef9a6dabmr876606785a.63.1793010017193; 
 Mon, 26 Oct 2026 03:20:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4002:b0:93e:910c:5fbd with SMTP id
 af79cd13be357-940ef9a6dabmr876600685a.63.1793010016682; 
 Mon, 26 Oct 2026 03:20:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a6ac6asm1437302e87.22.2026.10.26.03.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:20:15 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:20:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
Subject: Re: [PATCH 09/13] drm/msm/dcp: Register DCP display pipeline
Message-ID: <vd6e7jr4ciipj6ork5i36att6bamm4gpzxjdeqoqof3rdj2m4q@rtg7jop2bfwf>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
 <20261015-jshekhar-drm-msm-dcp-v1-v1-9-48aad0fe4f72@oss.qualcomm.com>
 <64603812-672f-43ba-9c5b-783d666d0ac0@kernel.org>
 <c7bdcdf2-1fa4-42a5-a89f-689e688af5ae@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7bdcdf2-1fa4-42a5-a89f-689e688af5ae@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MSBTYWx0ZWRfX1fQBv9ecNCY4
 DxDXvHLSVZo4okBeQHrHN8mUgSnWI/6rFV3Yq9Z/N+yvxpZ5Iqh1i9PnjqBZo8zoE7pV9iAjlTv
 Eead8bj/J7FdQsmpeKEQQ/EaAvjJIOvYrOGI5okYmN2S26Mq0TkH5vEkK2C8mvkyLBWMxMBaRvF
 68awcHqGQFWzGHaWU9BrRaH3i67s+2zT+TyFkYz2Tmd7lrkQyax8rkDNU44wWYly7lV/9abKo4j
 abQBAD8nUKGFltsmU6kqzOQTj9v9LkzAwUmnkmTVgmGX+Ov7DDeXYh6TX1Ql1RGQkox789m8DvP
 ebReTozRUis2P0hrh4ppDtBPJfq7ZiDC7p645r1U0vZswR7bf99e5DUs6ajyMIcTXoT6INeldRF
 ciqIjOQJ0pFzXkUUqkZdw/SdrTw7hQF9gN43qWtiF/FYvZCTXtaCpR0QOHp/4YYDsM0L6ByoS3d
 4fQaM7xOhLMSeN+ofNQ==
X-Proofpoint-GUID: SD7VVjO57uxkVbiEh8gn7ftFfGNokSER
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MSBTYWx0ZWRfX+HVe22+Gj6I1
 THH6a2GroNjvuFGZSip3QmBbduzNmSBgFHB/zgRPOFk+2x4lhEGKlCtETXWiS8ifuDZuNTYqhTD
 Citx4MzRqWKMs43lSlYCbjC26vO5VnY=
X-Proofpoint-ORIG-GUID: SD7VVjO57uxkVbiEh8gn7ftFfGNokSER
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adf2961 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=XPLrJM8uNFvCFI0Cpc4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260041
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

On Fri, Oct 23, 2026 at 01:42:43PM +0530, Jayant Shekhar wrote:
> 
> On 21-10-2026 17:35, Krzysztof Kozlowski wrote:
> > On 15/10/2026 09:38, Jayant Shekhar wrote:
> > > The DCP firmware exposes display resources through capabilities rather than
> > > through host-visible display registers. The MSM DRM backend therefore needs
> > > to build its KMS objects from the firmware capabilities and device-tree
> > > display graph.
> > > 
> > > Complete DCP KMS registration, including power and IOMMU integration,
> > > capability handling, display-graph parsing, and creation of DRM planes,
> > > CRTCs, encoders, bridges, and connectors.
> > > 
> > > Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> > > Assisted-by: LLM
> > 
> > Your tag is the last one.
> 
> Sure, but I notice there are checkpatch errors, should we keep this or
> remove?

Read the docs?

> 
>   ● env: :3: WARNING: Non-standard signature: Assisted-by:
>   ● env: :3: ERROR: Unrecognized email address: 'LLM'
> 
> > Best regards,
> > Krzysztof

-- 
With best wishes
Dmitry
