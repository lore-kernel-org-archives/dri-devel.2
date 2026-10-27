Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A9606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FSXnVexH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gVcurV4c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A54D410F2EE;
	Tue, 27 Oct 2026 11:26:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D4D10F3F0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:26:20 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RAeKwh1427433
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:26:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Is45whwqsC64wRcmSgLSpefzFyl+UElHhTAj2CK2HeI=; b=FSXnVexHsWUUmE7L
 WoEUfsQEmcNq/N2oKjYcqq/jsZA24/6h689K84srC3JaMsmNFt+BDnDa/KatF6j4
 SpkYQem8RNRZuGhfXi1Ky0ZdpoDVILBU52sk3zWWR2VHQsdgqmR4XX87Q+PChWuE
 mCiWwPDcEdkKbLgPqg1ofxaFPNVwReJf75PGkEzeL9mRDuIwAmVS7lLM/uhrm4x7
 nSGyT+dwCER4+AZuMpBm9Tq5SXdzOybCp5IKM3zQrEKVAckVYAQ8PCIll9Ajs4pj
 5oKnzwkL2v39ziiXWCj2CRqmrbwLA4UUNLo4ZswsTLTC2fvff9G4lAiWj3jhn3I+
 LKr2Tw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmmbaxx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:26:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-53568f05f8bso12970951cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793100379; x=1793705179;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Is45whwqsC64wRcmSgLSpefzFyl+UElHhTAj2CK2HeI=;
 b=gVcurV4c+dtrwyarHGXVCCCdR1pVTi6E6tF5iB3eII4SgbIJbzYqjxZAfHDwNymAaB
 /lKEnvP1lZPoPsnf3nJ6jzEMuzMDm/EWcfaC4Lb2sNFm0yiAiOoVuoJ06oE6OBcXhVb0
 0MYBc9N4Umj7VOiBbz4GYOpq95ncr0V1jCCllf2uK3vRmhqtM2rjysqcfPcjHER1fvoj
 uRsItQ1hAbP9+Ch7YU6uqqIJa6fW/E5IHSSI1XKKFIpktkkhM6ozAZWCyBjJw55ukJ3O
 Gfpd7voWDnSa6LYpGOe1HxwXAqS4KFid1JGgkU9khfP5qAtMMGdoSh8O1HRBGo9uc+2m
 qzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793100379; x=1793705179;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Is45whwqsC64wRcmSgLSpefzFyl+UElHhTAj2CK2HeI=;
 b=QyK6n2JsubQUliAybv8Rt5ztb6SzI6F9fhGjY7QjNSRIn5Yyrhun67nHmqhi1PSZOl
 WbuUMFPOMCTTXw7vowc8Gbj+QAnSx3Quz7bQa7sHZc7R+BbjgC1+hukkwzatdkhH+Wxh
 5rBKNBXIDFzQ6dQp5PR7NmvLGNU2u3xxYjSOHCdJq7r5329MjsPcKuMmdplYh4cJxaqB
 E3dIYhx5ybAnjFuMLvl4Sswr9Bc5RYgcL3HfxsLxhjs+5rl9JuQMG1Omc5BTiyrm9gMq
 70YdMoA7sO3CEbfs1seWnIBNmLCKx0nttt8fRVeIgVVGr570JScTEdTqcwAzYrpWTZ4D
 L0fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwExKaayvt4yES6HB2lNYkiG52GDmCXikTPWpe4yvP1KMs9IxqlwEspmElpYu2Fv11joVwqEARWu/I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYL6jER+2TZEJnVINcDh2NOUXRMMBbKSpt+Mp+QippM+xNarRgej
 PB45gMjEaPMXOeUPdb2eMscvzW5rLJvXDWONNm7AcvRvwjRmbMUapkJTltyoPqcAWokRkAjvzff
 7S/r2b40Nb7GWgy1AkwWSMCNmhCSCdrOYicaPbtTjrFfGVDyKczLdDVtotGXMMH3ysNaZk7c=
X-Gm-Gg: AYBFou0MxUKvIfX7vvFuuB5u/IqOuPvGlIgmY8lsFA8kWHJNmPTR7vJhVGXWrlpIDlq
 budRGb79TfgzAczBDY4vvZqxLIQk69uwWHIvOGpblNwZb0daLIVFIjeswt5bWl71pVo4Bp9hax/
 2WXGcypUQktubuHZ3g7NGpFHeZUFt0qkKpRRml/Ui9DlN0T1xmADGbi4epxEkIYj+TjP2sPXB2c
 I/of2iNwceIXTrUVNx8r4dC9q6+gMCb8yo+/dBs64BIdnAt1J8FnNbaD8gZCARrP7tAEoXrvZ/q
 bLPi34iPVKdwFVF5nvvM8Nk9Z2c5hLTBw/WfYGKmlbCZgtzMVhg1EfPoW9HOMuD4Xg/8PDXX5wL
 P3lYDnBoRbJls+UwbL2ctIQ==
X-Received: by 2002:a05:622a:e309:20b0:536:3519:de44 with SMTP id
 d75a77b69052e-5383b6426e3mr147751381cf.4.1793100378510; 
 Tue, 27 Oct 2026 04:26:18 -0700 (PDT)
X-Received: by 2002:a05:622a:e309:20b0:536:3519:de44 with SMTP id
 d75a77b69052e-5383b6426e3mr147750931cf.4.1793100378081; 
 Tue, 27 Oct 2026 04:26:18 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b44595d5f3sm4862904a12.10.2026.10.27.04.26.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 04:26:17 -0700 (PDT)
Message-ID: <ea023abb-6a84-451c-8f98-039b8e4f5148@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 12:26:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] drm/msm/adreno: Add Adreno 620
To: patches@brar.si, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261027-adreno-a620-v4-0-b0095e028c76@brar.si>
 <20261027-adreno-a620-v4-4-b0095e028c76@brar.si>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261027-adreno-a620-v4-4-b0095e028c76@brar.si>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfXz/QL9ddNnrMY
 sx2I/jFOhwAcSTmuZQ0FALDD7mCSIoBpNMqYxibdC1cNJxf0q3Q15L9rB9p4wxT4bs1nTjSxtAM
 6yvNTkYYqaoURpdVNRC6hLmkRzR5G/A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0NSBTYWx0ZWRfXx17fOZlxnGNe
 aLZRG5LYe8oeDH4h5geELarnuvvQBNogmVqYF8i5EwbQKE6y6+RfLHa4EAmtA0ModLLMASE/wHq
 tCOlH5sYlq1psFB1ozxPjRzDbjCqk9glKUHHiTrBz33o7FlK6a/p5v1+5ikulEgoDp4gN4Xqquu
 nxaxnHBv2yURT38p72RjGCo6FKwR1xRJrT0VbUbomZHLZWQ+r8jX+ckatVOk+fgIRA5gP/PajLH
 FS3n5f6kNAQ2FjCR/c2BVmvp+AlQVC3ji4MIswKCNSUGL1fM9NoYE6Gjyf6DhTzteKQqeYq1VfI
 rw9GpCKm1m/hfT1m3mOIwik3XFes7pnmI5hEbWmV7So9sECvt9aNGSeh0dQwGj630q7N3j648dy
 gqR+8+iszABojwRRgQIf+jJguRwJL20njidGHlEiJoHU5/yvomdTgLeHLG4y4ieRM4J9Mlov8+i
 FDThn27J3EmWkZQ163A==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6ae08a5b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=al468FGD6oJmqlhVjCMA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 10me5WX9pruNc6rfTzjAh9_UoPiwkwSq
X-Proofpoint-GUID: 10me5WX9pruNc6rfTzjAh9_UoPiwkwSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270045
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 8:14 AM, Ishu Brar via B4 Relay wrote:
> From: Ishu Brar <patches@brar.si>
> 
> Add the catalog entry for the Adreno 620 (chip id 0x06020000) found in
> the Snapdragon 765/765G/768G (SM7250). It is an A650 derivative and
> uses its SQE and GMU firmware and protect table, together with the A620
> zap shader.
> 
> The speed-bin fuse values map to the OPP bins as in the downstream
> "lito" devicetree: fuse 0 is the default bin and fuse 132 and 115 are
> the two alternate ones.
> 
> The GMU clock gating mode is 0x00020202, which is what the downstream
> driver programs on every A6xx except the A612 and A615 family. Use the
> shared list of Bus Clock Managers so that the GMU bandwidth table is
> generated from the bandwidth levels of the GPU OPP table.
> 
> Signed-off-by: Ishu Brar <patches@brar.si>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
