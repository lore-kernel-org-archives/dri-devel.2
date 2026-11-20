Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45784606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XLQhuATv;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rjee+52B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D9A1127AF;
	Fri, 20 Nov 2026 09:51:22 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF0B1127E9
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:51:10 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7f15c606035
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JVyI8XzJB+HjkVWzBTxdK27XAVBVFV76hYAsFq4nkK0=; b=XLQhuATvbqxovLlT
 dL411IJrhlAJYPNrAhk0mgGnBLMSHr/hV8iTE1AqWbuQQdAoTrHyzrFCtxbrcwQf
 DY6xYi3BhFoT+o5+BDMztoA+oWyYqEiqXXKJOkkfL8JdScJdLUQ26+9xJvl8Whhi
 +D7eRf7/P+sYWAztIAEKOZku+V2bVaYkRqwj8ir6fh00+SejGPOWLEtKzmPxu6F0
 VQE4cGvqAWhoRoiSUKqmRHBbrIapkRDF1fJbBXVBvj64RreyBBgssxLA7mXllHZh
 SPzEv0qRcSOsjfTytxwHjef0zixTExVJc13XINk99ZZTm0kCe+Q2/0WeNOTQ6SiR
 Fa8FgQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2ggqrx2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 09:51:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f20addba1so137775385a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 01:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795168269; x=1795773069;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JVyI8XzJB+HjkVWzBTxdK27XAVBVFV76hYAsFq4nkK0=;
 b=Rjee+52BEDJn4N0LN5cfLYeZcSRnij3JBzPGEuRx6EBwhmvT2sOqMcdO+27RWI2GF4
 JiUFktMz6gSoNBHPIrc4riRwhhjEsVqpJkpYmraJIday/aeqT1L4PKrhAvwtIJSlntz0
 fA/YArpfrVycX/DTue/o+D+eWjoDDRXirWo26h8RoDBcvexHBO199wEJQ0laYh8p5zU6
 I2+ZC/699C06+8e2OnlVAUYa2Cp2xQX4N4J3ag6AIuB+tdmsVN/2PUY4I+aeZbN+HXK5
 1r06txj6GUSjros+dD1xUJqKjNjQvHblitw9rElfk8Vvp935mTvnuzHizVYNm0AchVfG
 KRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795168269; x=1795773069;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JVyI8XzJB+HjkVWzBTxdK27XAVBVFV76hYAsFq4nkK0=;
 b=DdLeu2kumuQjkS4vBjSSRkVw3J5N/lwx1+UWiWDdu5iHlbPZzlLctglmjiq0uOTAyX
 w1xAeiBCD2XgW90jeQLNo2PE3FCYf9+jsuHs9EeBC7C7jEQORTlJ6Ok89MJKG3LHMImt
 zgKq3SnSGt/spBRsKh00NMA+j0LRCjLji4R8PvvT8cYtjgVevnlURduVsU+oIvahy9Af
 7Q+pRJGFJFTe2U4qwXEQj7pA1BysMDejlQPcPtDU4DPwehusHhwNEXRgvUFvnaMkQOir
 PfjXo8IYT1cOULtcrW4OU+0XEMUI9YmKP7idgx/8ATnzRA7hFgcSrTsFz4pL/ZGOGH5p
 4iCg==
X-Forwarded-Encrypted: i=1;
 AL+hErHca4vJPxnuXw06M1L1JdP6XLC6/LTeIUrpkGJ1cp2/bK134AYnQKLhy4WW8AMPERLtddpH39xqNK4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8dk0lE36PbjcI1+SSyDwL98ONXliE6fv+Eo2rwxZ1hhegwfHeO
 Mp/oxCl0GXzHiQziGS7FoaJvfAPFc0AH047aLGM6vw4hp26y4KpYFJGOkW+iGndwHvUK4MjleqB
 9+vDC/aPIhbHkJ1PQISMecsNu145TtYR5+qPPC6njgFqaGCE6K/C/SMMnKo6OQhopF8wvAUw=
X-Gm-Gg: AYBFou2D9YHXf+/X1bMLNS37NjHr71NOY4dddDLb7eQjU/QYfnJDi0Jt9cI90LiJl68
 8I6DBJsNvKjYiT/Wh1sWelpVKjVc+BhGfc19W5j6bVJX3mxwVbdW3I0vgi/ujfHX6EwHRTGnrTs
 Kl14ijoqqXl31NjSxwbgnDF2o5aX/EIs/yc+7rVoAjqMoDleGhVunSVmHQme9GsDeRqRSmTQy7u
 fkbjDEQPZSG02WvU+52feS4i3S52AhrnBcErWmNKkt0B1T/vmQWfrqlglzSdRsARX/n/q2DZ5YH
 LTswOCXcBRnq+pKT8Q4akPZsIjY+yh/j6LukKRFBeoYXwhsWM/yXwOJb1MzIoDJ8T2675mADiJW
 3uXinyznenSM5Ev/q3jOJbs59OXCoI1jBBw4OvgUt33/Uo1/tvDM6EUsCGj6hJwmI
X-Received: by 2002:a05:620a:8081:b0:93b:d7a3:45cf with SMTP id
 af79cd13be357-949ba9e882fmr372403385a.56.1795168268945; 
 Fri, 20 Nov 2026 01:51:08 -0800 (PST)
X-Received: by 2002:a05:620a:8081:b0:93b:d7a3:45cf with SMTP id
 af79cd13be357-949ba9e882fmr372397685a.56.1795168268270; 
 Fri, 20 Nov 2026 01:51:08 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d60sm4524417f8f.3.2026.11.20.01.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 01:51:07 -0800 (PST)
Date: Fri, 20 Nov 2026 11:51:05 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: nord: Add GPU cooling
Message-ID: <ajoxvv5enftdx6phawevgoky3hijrk7asx5g55u7cmcdjrlntx@syh2k5q27bwc>
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
 <20261118-nord-gpu1-v2-4-8d6d9908b7c5@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118-nord-gpu1-v2-4-8d6d9908b7c5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX1t4tDjmbdChz
 5hekfFQWUni5FtCN0jRENl1ZtaT2rZzq/JVMr4ENnymslTro96DeThgPsA98H8La08BDsfgKLi3
 15CulvhcsonM8fZ/ZRM4DSmV4OtOPFTazsn/aIA0KsCM+T/nfyzKqh/ymcfPuYEA4h1vLVVSUpU
 rXqUaciw1Y1j/gP+Q+U4lN9zAvoEalzh0Vh/Jnmpfx7p5bYo4kyiziFZoEazX2jvzOkBHvuFL38
 /iviRxYGNEzmB4NhV7crnnWDV78FDP1yhcpztnkPf29d3oF3kjEhjXi0w0pCYu0YTzplIC/utE/
 xjXCQ6H7PFOpWSapZHsnFmCst/6+3BsnKrHLihBhnFd4LjlqhXgvqOci0cyy/CPjGEcaV6ZqVXu
 kY7GZLz4wi3kD8fXCk0RoIk/k6kG/J0V5lbQA35Q2K/yP1zuk6V0LFxEHqmKd99eQ/E9OZitZID
 6GNuBcLzvbiaECoZ7/g==
X-Proofpoint-GUID: jQp87zZ7wd0D1DTVdna0aRF2n9qECmZw
X-Proofpoint-ORIG-GUID: jQp87zZ7wd0D1DTVdna0aRF2n9qECmZw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX/77BO30mKZK0
 Dm13P7PK6sc8KzqJOVJ6xZdxm/XhFkOuK0L0I85Gso2EqWcoBIWc87oxa7LLDHL/Oo785BPTQQ0
 4eAIboM2QC7MKrsyoGTswrwCIGWdgZ0=
X-Authority-Analysis: v=2.4 cv=CNy/zhrD c=1 sm=1 tr=0 ts=6b00180e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=r-Xe3uw014UkFQyex58A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200039
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

On 26-11-18 04:30:07, Akhil P Oommen wrote:
> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when
> it reaches high temperatures.
> 
> Set up GPU cooling on Nord by throttling the Adreno 753 GPU when it
> reaches 105°C. Label the passive trip points of the GPU thermal zones,
> map them to the GPU as a cooling device, and add a passive polling
> delay so the thermal framework can monitor the zones while throttling.
> 
> The thermal zones and the GPU node are both described in nord.dtsi, so
> do it there. On the GearVM variant the GPU node stays disabled, no
> cooling device gets registered for it, and the maps are simply left
> unbound.
> 
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
