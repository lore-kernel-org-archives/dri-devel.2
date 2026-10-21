Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E1606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UlTyuTus;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fL/QeNbt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98A110FD75;
	Wed, 21 Oct 2026 11:16:41 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 285A710FD7C
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:16:30 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LA6R0n282269
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fkPmOzv3OgvoRDjNIIWJpFQ5aARxfWx4gdCqfd4sloY=; b=UlTyuTuspJTbmMcH
 TbrdWoyGP9Fc4ksN8AP603nQ5JSMitl6SGjKkcJL6A1xjJ+RvA5CB4Buzq0FYP6P
 zO/EhRjitSuLTpqfPj/KiOqAZUouh1jnh2a29eP0ZMWFBaAfUiKryACuZmjToJdE
 2+FB8XRZmYUKQupgsJ4TenV8dLAldxr+Mj5TQc+aMatuvNZfCsWHVqAXWRAbxUrq
 1tyUC1rpg33NVSZeVbqngcKuycHB99rNqcs/FMRbujq5Lpmiwi7frL/ChtxIHlwz
 rZqPFNvYjnNBGfgNjsk2MeOWjCeJ55jUug1EkcHLLTRg1rh+JJLh+EjZb4kh2q7J
 fztWUA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heh5r2qjf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:16:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso951755a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 04:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792581388; x=1793186188;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fkPmOzv3OgvoRDjNIIWJpFQ5aARxfWx4gdCqfd4sloY=;
 b=fL/QeNbtao7Nh1o1KaCjxYqPzaF8+zcL19Q8l9lVC7GU2e8F1AVq6JFHE3EpoQ5OjO
 pKXn1qsN9R+JM6QE6X4BN8EXO6wD3aypx+eHMlpnfOEPVhgWeSjNTKmrT0yWX8N9sAJi
 pgf1Olvjmf3U2Pu0NumOEOKfa3UhUQUE7XTQMwPsuUjxqvWqp2bGQijaQMngrCosCV78
 LHbFx5h5Tp4zCAE1l2hTbIRc7HGp1S3fqn4eQrTd2i76R9aoBGn2eZhsTUce65k9F+B/
 QPa+Q1gk/Tpe6CfTcCD2CJMaFnlNLKvNJHdS7muc5WwyfuVhHVVOyD96/E1I9pqk/Kc4
 ETDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792581388; x=1793186188;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fkPmOzv3OgvoRDjNIIWJpFQ5aARxfWx4gdCqfd4sloY=;
 b=rro4EJDwzgl81DUD2Aq3BWTdQFcR+vsYWcAPVc8RdJFqnLBFO44wwQLEU2YlPlxbIT
 wb2/6EBRo2YQ6UceRgxXzj/SZvd6jPHucyVVnAZZW3hZHeQ/xnaoaLK9PvnnQ0ZgN1WP
 6GRQdtDsQitaUOCH96b56iW8VgKMfiV6yQjck8mXydYxEjxZ6OmUpj+zg6S2PLaWrPpK
 YB1bhMJpbKXmq/WTAahDuvzLVtI3rMDATuVtLyxk+olSe9lDk5oDU/0QYma1sp99WxRI
 RiBw6jP7CyW3Ina2ga8qQbT5KvpHpp5TLN1R+AgzInH9UeacEqho64JiEQXBuncGlTCK
 cGCA==
X-Forwarded-Encrypted: i=1;
 AKwUvByjB9aAvYK3CsK+blc4pEi/GlfBULN/T7vbdFU62gEBj8PzETUQXpfaZWDZomqcAFGHvy8UnA7fR1k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKVnrZxxgbA3q0hpkCQIAGHr2Ah+m/1cpQcONtXuVWNsQNnnlKw
 iUz3rs4e2C0Iwn6Eg7eRkrrl703n8NTZuwNrn8FXVgZ+n9/ImZg6jCxCtLSpB/6o2pNQP2QNTEY
 r34/x8iZrAizukGn7RilgdYGZE2PnAj9NiEXk/KOBVAd3wZ4+/YRkdmRe9RMZUGYwLEoc8sg=
X-Gm-Gg: AYBFou0QiO2J2zGTpnwJ8B6RinPC5yjxJ7Tsw+Xzevse6V9SWcgHkuxebpld6NleIw4
 EcUcXSi4JUep3PMeuUkCvN1Fd1jXs11vPK9JmlBZQOP5cfrM1WWD3GUy5p21DKaOwh9oZJ9CJjb
 fY9z02G3GtyEqfvQ3aJEGgMUaRvWY1TEqTcdjKhVqwryU920cSbNiXR3NIzbU9qX/nCjsfV556j
 R9S1Xm0witEd0FJFIuFOJKr+RhPD4ylsrFc7CVpeF0ZXsoyMDOkUuwKju0uaDqpIIviOPkR5QdT
 T9Akr6fCW50Oiqmy/zA6ojJjLR6lopkAjvcCub2S6+IQv7JSUAx2F00rkPd2d93KhgTFc7it76c
 em8+/+l5yPwLWQn0p3t4gxcpIOzjc
X-Received: by 2002:a17:90b:55cd:b0:3ac:929d:ba5c with SMTP id
 98e67ed59e1d1-3ad86f49b66mr1399593a91.45.1792581387581; 
 Wed, 21 Oct 2026 04:16:27 -0700 (PDT)
X-Received: by 2002:a17:90b:55cd:b0:3ac:929d:ba5c with SMTP id
 98e67ed59e1d1-3ad86f49b66mr1399567a91.45.1792581387068; 
 Wed, 21 Oct 2026 04:16:27 -0700 (PDT)
Received: from [10.204.78.119] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad80912f26sm3948228a91.1.2026.10.21.04.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 04:16:26 -0700 (PDT)
Message-ID: <425ddb41-cfd7-4032-8666-0193ab6b5819@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 16:46:17 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] dt-bindings: display: msm: Document the Nord
 DiplayPort controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
 <20261012-nord-drv-dt-v2-2-a2ab9af954d2@oss.qualcomm.com>
 <20261013-tangible-wakeful-swift-a38f8f@quoll>
 <20261013-honored-bear-of-cleaning-bd8108@quoll>
Content-Language: en-GB
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
In-Reply-To: <20261013-honored-bear-of-cleaning-bd8108@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aI5lOr9m c=1 sm=1 tr=0 ts=6ad89f0c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=D6Kic2Gw2dsiznywmRUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: cg3sXSbse2_ouURqtpKfZIM9_nk1vPBh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA0NCBTYWx0ZWRfX7zHj9IlGcuBl
 pd+vEW/wEzxc9TlXA6g1GPc1l87lwqWfRyNM+/rwidCCZUoeu8G9ig/YXetq6EUjn+QakK0ZXKW
 4qZ7HXPzbEx3gFYeRnptZMaEkOGtrHX9xAqB2Ez7AfFoysXQ3K54pHbx4g/wABaxzn5XoHUSxlV
 HXAlk37f4j276g22y1YXnYfz5JB0KRgKm46kEbA60vgfx7K1AqtDApmJNMEplUtE6iuEMlIZLEX
 go4+PazZNrwrTfiFeiqoQ4CiANcsDdyPMNIOi9Plwpbl+PpzBnXI8WujoQNkdwhMZirhl861xZA
 rDw2REsMIXZ0Lr6wSBmcQAOZltrOZDYB3sWVZrqsFyHPaQ7muRSptIfQGEIdZjfwbpuCUPtm6Ar
 Y4MpzoeW9/9FbZAI7bVqBPj1Uu6pLE2BLKufASSBLORajXQ3fWNWwS/rfoBotDNw9ToUVt1Prnx
 bGBH6kWPKH3vp6HSsdQ==
X-Proofpoint-GUID: cg3sXSbse2_ouURqtpKfZIM9_nk1vPBh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA0NCBTYWx0ZWRfX7jl1XZvkj6N5
 szrKpKw4BoyRgmpmQ+VVYcY7hDwHo/a+ak5Yee3l1jBVMe0fylbqtgrBKtHR6VmBWETpjG5D0SX
 SFiyYAqFUiPl0TtmjH9RKUFtmyzaAE0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210044
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


On 10/13/2026 2:18 PM, Krzysztof Kozlowski wrote:
> On Tue, Oct 13, 2026 at 09:44:15AM +0200, Krzysztof Kozlowski wrote:
>> On Mon, Oct 12, 2026 at 07:02:12PM +0530, Nabige Aala wrote:
>>> From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>>>
>>> Nord uses MDSS 12.1 with two independent DP controller instances,
>>> each exposing two DP cores at new IO offsets. None of the existing
>>> compatibles match this layout, so add qcom,nord-dp.
>>>
>>> Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
>>> Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
>> Do I understand correctly:
>> Device is fully compatible with qcom,sa8775p-dp, but a simple to fix
>> driver limitation is preventing compatibility?
>>
>> If so, let's fix the driver - just add more addresses to the
>> msm_dp_desc_sa8775p array?
> Or it does not matter, because top-level MDSS anyway cannot use
> compatibility?

For MDSS0, the DP register offsets are same to those used on SA8775P. 
However, the MDSS1 DP register offsets differ from SA8775P, and Nord 
also utilizes a different MDSS instance. Because of these differences, 
we introduced a separate compatible string for Nord.

Are you suggesting that Nord should reuse the "msm_dp_desc_sa8775p"?  
This would also pollute the sa8775p's desc table.

 From your perspective, what would be the preferred approach here?

>
> Best regards,
> Krzysztof
