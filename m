Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517C5C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6372710E0D2;
	Thu, 13 Aug 2026 08:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSSsfnwN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kQRdk60L";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E5C10F1DC
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:06:47 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5g8J81530199
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UgCNASx8qOprTigY2vUWSc5n1J6xUE08JXG/QdWQCDs=; b=kSSsfnwNnkLn6RyS
 s9jhIm/Srmn6Lx10b17hYnBaGxLWif7LxqwYr58x9AbPnkGdvbaHXJRpkBAeC7/2
 oVe52FjGcxgBZI3GcAbmcdQ78mIkmSLDNIxoXXw4VuphhlNKWpDsT7E92R3BPemL
 Xn6IGGTSlZVYVNurSenT41WfcBlL7ZbQ/9mz5BsemmH8EYfSpKRcejuIGc07k7AV
 ACB4L8BMwzVkE7l+4bgZfGoTwkahYf7nJthMDkQ4efkH0Nn4fYjstbrOKipAMCHy
 K0LpmWY2/uo94+VuI+FmCY/Vz+aup0o8iqTm319HMKq10RCzLinWrCGkk9Jj4Hnt
 pPSJDg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g143hsctw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:06:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93494527488so322666985a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786608406; x=1787213206;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UgCNASx8qOprTigY2vUWSc5n1J6xUE08JXG/QdWQCDs=;
 b=kQRdk60LO3qS7Pbl2nOgBGZSxuYWv3rho0Gg5V/ID3XGQOt8fSJ2O2ZYcDfu704rqR
 BOCwRJT+8vTgvy2DD2L8mluJ7KnFs8Jdb70IYBDLiDC9uoUyap4WvkAUTOrLwnuA3ago
 xV+6OQA2/esWjtrjqllGk8RQAHk40Rn4iZ+iGusgPf6PtGhBq0V163xSkRqDrzHqm3tz
 uijXdOfRQpXQzQc7yOKkst7ViMFzdv+iojTCXirFPQtTUsBupn3xr3iTf74j/dZohLSZ
 HJtV0SfOblNwLg1LS/BgR1vX2GkJO/3TC7g/LLxLccaD0QcIUWLTHr+fmMh6qlTgU5Ee
 OmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786608406; x=1787213206;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UgCNASx8qOprTigY2vUWSc5n1J6xUE08JXG/QdWQCDs=;
 b=L8RFAallB079njkH32ZkIjmYRNhrhDKbvdOsQH9Ub1wWfdNFKTxtV9XEI5D4XLhBaL
 NWNyaTcT7pVxODCwmGAvAboxLe8fuMZrBGEpfXU859xGXszzyOMGWoCjlQiOO1X5WlWD
 TZFIMG078+mnl5c9sYgfKmhjq4oxieN1Rl6+DweTwXTzqsCx/XDjldSyzagZVDXVAkyT
 /7qZ9hCk1k2M7lkn0knlriN95M8WrfisqW0/VmlnFjzlPjaLq6syuFhQIOImLtEjU6fw
 fjx8hcnCKp6Os/IUxOD5yhxasJocEQgK29J6xDCEwkCQ3j7SFdrMCNFB9JIyLkMSw/uv
 jOYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIgvLxkvEXHtGSipaJzUIf2gNscrCVwwP+FDvd5jyX9daecGbQJiWp7f9vDpWulYmgJEDZeZuN7Wo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmnyWvf/LgK/j1uGXQYp7MqG7K5Eiwj2Md3SLEtMJkDm1bA41B
 yl1ceuMfwSybL5XSf80RbeQchHwUhy6+0M+OilSw5u3CQMCwL6rxi+FMmQy964lEwrIkkuZIFyy
 yJVvB4OWb+ruFk8x1u21XDaK1d+JSCnav7RasSztLqljutrrwGI3oQUN2d/jjNg4Y6prUsbk=
X-Gm-Gg: AR+sD11CG3d7miOGt6/c2irgnQYJiy5sSq2s6e19bVwfQtaTvyYPwGYjPOLBKBKkfev
 vTzEiV8qVmuGCnSijDOA3DNHBncq403ZoMnGdgtEO8Aqlk9M4zaiGhB9efyHDIMlfN+bnaix+m6
 ZJ5yje73qBZf7zmq7zettWJ9tQXKnEBdBXHCNjHjA1slYlB2N5T0kLHBSQ/vAYaRh02ctfzR0T9
 jeY95hZ8pkpX7Ot8+l1ppCpOykA4OJfFr6a0hBxRZoK/5v3TtXDmXr9K+rBdEc55RzyT2pZN4Wh
 f5cDIncaORzUstnOgAg93uv1VRfB75CO51kSCwV1LYbnK8qV4qu6bshQYM63NODPeHJG5HElQHr
 TwmtuVILb4uEnU2gmSz0ASglLoLc61lTXOmz3DR/g+8vNUmvFsnTuc3KwGMa/8MBH
X-Received: by 2002:a05:620a:4721:b0:936:583a:dd75 with SMTP id
 af79cd13be357-936bf8eca91mr390520085a.17.1786608405929; 
 Thu, 13 Aug 2026 01:06:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4721:b0:936:583a:dd75 with SMTP id
 af79cd13be357-936bf8eca91mr390514085a.17.1786608405459; 
 Thu, 13 Aug 2026 01:06:45 -0700 (PDT)
Received: from [10.111.164.29] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936c19988a4sm96648685a.18.2026.08.13.01.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 01:06:45 -0700 (PDT)
Message-ID: <edf70a43-feea-4688-ba29-1c00748a55b8@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 16:06:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Abel Vesa <abelvesa@kernel.org>, Yuanjie Yang
 <yuanjie.yang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
 <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
 <5jozediov63riomokjzcphmpkpfqdgl73j4hd27vx6yttyddar@7bvbitl5ag2s>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <5jozediov63riomokjzcphmpkpfqdgl73j4hd27vx6yttyddar@7bvbitl5ag2s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R5oz39RX c=1 sm=1 tr=0 ts=6a7d7b16 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=R0RQ14XjvGgjv4nrYs8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1NSBTYWx0ZWRfX9odpiHH1tCPw
 Wa9nlaAFxQzez3qaRtUvmOgbN/sc60t3UxPwipFAzX3gT9Y7piaKina5Nn3cIlZ+AB/mFpdQT8I
 FAAenO1h/v+2BfGdRompGcXMlSQTdSS7baS0LYINw0Mwl5du0jjeI7V9i2ayRvNJ4fhnjiyQOgW
 UQDJToymleW/xftXCN5RrGuNzCYsUunyeLqtSytINDs9E8IzwWiKaPQ8Y9le1oW67lBoFB4LjEf
 qEWnz7UplFoRqIJ9DMzkB40QaMO4SbaR50/jFBrwOFiEyugzJyrhYkqKs/hB4H4pE2FDyGA8G3y
 2XNzVPXlJGgG1hoZl1lQ+nb8MhtL/n3vDoT5aP7cjkNA6kql8dacM6IZISS4AbNJAZ6QBfvlZk3
 kopYlIMDIx8fo5vacigsQdqAIHTjkks4w0iJV97YFGHdjrypcaKNhgc5bBeI/Bn+PaOkWW+BTms
 PMgsBCvqJAeZnmHWhXg==
X-Proofpoint-GUID: qktncuMnPzi9yP-HadGyPYBvRFkuEoTJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1NSBTYWx0ZWRfX/n56WWG4sUJb
 lCZntbdCTpJv/3Nbtt9vCV1XFeXlI320slJrGe8fOhwiN+9PSMQUVHRwfritzOOTlYzAQgIzzUH
 xS5DFvoirHeL2XKnNbkvW4PmQ3aY5KI=
X-Proofpoint-ORIG-GUID: qktncuMnPzi9yP-HadGyPYBvRFkuEoTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130055
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



On 7/22/2026 2:20 AM, Dmitry Baryshkov wrote:
> On Mon, Jul 20, 2026 at 04:43:53PM +0800, Yongxing Mou wrote:
>> Kaanapali (SM8750) and Glymur use two display power domains.
>> CORE_GDSC powers the main display hardware while INT2_GDSC
>> powers a subset of SSPP blocks.
>>
>> Allow the MDSS bindings to describe both power domains and
>> their corresponding power-domain-names values.
> 
> Another question... If INT2_GDSC only powers up a subset of SSPPs, why
> is it being declared as powering up the full MDSS? Can we move it to the
> DPU device instead?
> 
Hmm, yes, it only use for VIG2/VIG3/DMA5 here. we can move it to DPU. 
Since listing more than one power-domain disables auto-attach, a small 
driver change is needed to attach both domains explicitly — MMCX with 
PD_FLAG_REQUIRED_OPP to keep performance-state voting working, INT2_GDSC 
as a plain runtime-PM supplier.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/display/msm/mdss-common.yaml        |  3 ++-
>>   .../devicetree/bindings/display/msm/qcom,glymur-mdss.yaml   | 13 ++++++++++++-
>>   .../bindings/display/msm/qcom,kaanapali-mdss.yaml           | 13 ++++++++++++-
>>   3 files changed, 26 insertions(+), 3 deletions(-)
>>
> 

