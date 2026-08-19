Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C77C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2399F89D9A;
	Wed, 19 Aug 2026 13:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="phx23G3q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T6zOqJ2B";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB3B89D9A
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:23:39 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JD0Jwj693934
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 esjYOP0cHWLWtJ/S0JzZjMyOobiP2YG5+HUVououevY=; b=phx23G3q36vzMkjD
 VzSOvzfRbKIAW+NIz7GVj/qufa67rrbVOaMgGYh5Vrz/zqSJprH2dHldiPQRoFSW
 sL/UvxndBrdBv4jcC+3gdRO+ib0m+i66VpURNp2yiEQa1txsI425LCh3WG5tyiXx
 PKYaXmLaDUEUreD2ZIxm/RmYvnARoQYjAup3yKJ+rEan1pc6LEdDWR1e0VBgh94I
 ecdJaJYTpYdiw0msc8AQo+ddKlmh16ekSYkFtzXqh7NANfW3C3VJxQbf4v5ClHej
 epJIqB6zEwGILuMhCWFzoywy2kbxqPQ9xIX8ePXSmygwIguQuVx+ud+uZzDwD6DW
 Qm6OzA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfmbcfg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 13:23:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e8e864ef0so2065035a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787145818; x=1787750618;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=esjYOP0cHWLWtJ/S0JzZjMyOobiP2YG5+HUVououevY=;
 b=T6zOqJ2B+y16mpPeMkBInLIRoKDLD1Z5TX3ddHaOtl6BJ42comjghT3mivacdSkN1u
 i4FMSIoTQ/8DK2v7ocCuhVJgnVxK9XZn+4ZQzLaAANjd07VA2SJKDHOo8M/Q5OqQlQKW
 ULqEf0d1ijq2W4/PmXFYcveko7+UBJwPOOw43j/A0o+gFHQI6KdELA945+M/MW/J2eMB
 cvEsXsD2jbhxPpy4vcSUkkE5dDq17OtsLAeQv95UZS/L6DjSDRMVG61D5OXeATINnJOl
 z+JnwcUV3+QlOWxerVF0wHOwhv7sgmz6NaeNOjQ5L6uRe+f566elA+wqzHfugzNX28RU
 Ip3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145818; x=1787750618;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=esjYOP0cHWLWtJ/S0JzZjMyOobiP2YG5+HUVououevY=;
 b=fxRZy37SnUe+obz/3Lk6esdE9iShixzzeY7o2j9BwohImKcLlCNlqtgrI2Ze1ihKb0
 5MYMDcFqvvuSPGHg93+4eBsdBPYnUN/QTx7he7AoPjw4gwH+yNjWjsa/WFdg4f4rdiwA
 q4OuvrSNNvrb4YWkddKOr7uGDLfXsQV3Mglh6k/OV9EV/577wnMebHU0CjXZbSHslUsb
 KJKZEPVNKGlKigX7RR0PEMKRY8kAg5bhceleD82cK1pJNpW/I1tUTlP27ThxNmFNIf0Y
 9RCKGO6UIfoEr6XSO01SL16blqwU4KLHui0LH6YiCeIfHqwakUMBLQIIf70W8QAha3t6
 tC7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoZRBqrAxyzJNqhAKBM7twemqOJ4NJ8aeMSKukrC04V7NjnDeD54PI/tHN7V0SKr2aSwSQqXQU5YBw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ltyYtSbchFK3ceAsEppTupVArL4WMyiMtN5yNUmo7kiWlIriNW
 PtQ/vvPay9PzSwWZLm8iA2PcbH8+MDgYzc5MVZ+a1IMVRDd1rKbyv7xxAIMMN1FOhwAuyGIB44h
 O4+9IC1gt+k9xgVynqQl3VmEpKXi+Hq5TKIzcerV3o726FJrwC1tLy4MHADqsZjkde/oJjMs=
X-Gm-Gg: AR+sD11DHMTLP9O37EYrLvnMe9Ab+7HkYuN+u+rvfBimQV4bzi0g2Oco+l4/bJvytY8
 yp0kqkw7Gx16YAKyWYj57qt7/qzslE9UQk2LQetJgbFA/Nc5++6R7Q+eTRC3+B0YqEdjX7dwscJ
 UeF80WaK/MwQOLm5JOBo3nVJ000iUeg/SpMnJ/UCWWFUvAJkdA27FyY/bd7QHys88egoJaB6vC2
 isn6W3gOr3s89kCKkGfQPojv+BSBb3oHZUGdWTC9VTR7IV3ZO+urzyZnjWb6EMuENX0gwYE2PZS
 37Q+HRSC2mOxLrkDtTy0SfsaPSnpnmELtRc0EETtnve4Q4lcuHnCnaZ1cLIWvj7+5tl2BR4UsLf
 YRTb5LMt4Xz91Udxj2J7uLFT156LkOw==
X-Received: by 2002:a17:90b:4d83:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-39580a91ad5mr8388497a91.2.1787145817298; 
 Wed, 19 Aug 2026 06:23:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4d83:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-39580a91ad5mr8388382a91.2.1787145816848; 
 Wed, 19 Aug 2026 06:23:36 -0700 (PDT)
Received: from [10.219.56.166] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957f9aaa12sm2843059a91.5.2026.08.19.06.23.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 06:23:36 -0700 (PDT)
Message-ID: <cf502956-8c99-485b-bf25-9f89d81975ab@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 18:53:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] accel/qda: Qualcomm DSP Accelerator driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com,
 dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <f009a2fe-5c30-405e-a942-696ea65fb2f3@kernel.org>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <f009a2fe-5c30-405e-a942-696ea65fb2f3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gwmPVer5H6IpxNa2_K3D1ZWA1_DgjHFS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNCBTYWx0ZWRfX5QqJp83kiZAq
 pWoOliXV9yQ5QJPcyYtN2LTmcUMO50SwDCwqhPnX5ZRixArc0hMbBpbHRFYJ6LbEMOky0rHzhqg
 q9+H8aooHUpfrecrjfHOG1fX7mhNdBk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNCBTYWx0ZWRfXyNxEUAdmLpIg
 5rorIgRpe3K++0z5WDmKf9k3I/2V1vRFQxYG4QGn79cWw9/yeiytp/JknEwo3rmkupGUta4bECI
 +JRZGO+g8rUtMll3h8j6FQfy4uR+t60ywqpOSh8TrWRcNNaJlBO8vxbTbF7TzFZU7cN42TE95mJ
 kdf4hKUw1NfW67tpR6GCG0vHX4hDGmubdripreFmFEG2hRd2c/Vz+FvJ73Csb90NyPl/fibiGR5
 m0qjX7k4+3O9m/Pr0/w4D9R0l4fxqJQMleV5EdzxfXRIQj7ERqoA9lYhfHtw3X6614TbUXT3qpF
 LSQz/C/wowbG2qCx/LmggJjKVPsrPBZLfuVwsF+IJ+fIQKV++LFgaqkuTddeTl9CD8GOVt9vJT9
 bySNNzhlRacnRPfs3XStYKXUns/KzM7fIaAzsscMamdG+GF/6Gv8UN3slD7ORzxMEXm/fNTissM
 7N2k13lk+n92cuAyAJg==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a85ae5a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=z9ogCWloIzyHX_id1hcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: gwmPVer5H6IpxNa2_K3D1ZWA1_DgjHFS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190104
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

On 19-08-2026 00:48, Krzysztof Kozlowski wrote:
> On 17/08/2026 06:47, Ekansh Gupta wrote:
>> This patch series introduces the Qualcomm DSP Accelerator (QDA) driver,
>> a DRM-based accelerator driver for Qualcomm DSPs. The driver provides a
>> standardized interface for offloading computational tasks to DSPs found
>> on Qualcomm SoCs, supporting all DSP domains.
>>
>> The QDA driver implements the FastRPC protocol over the DRM accel
>> subsystem. It uses the same device-tree node structure as the existing
>> fastrpc driver in drivers/misc/. The approach for binding the QDA driver
>> to device-tree nodes while coexisting with the fastrpc driver is an open
>> item described below.
>>
>> v1: https://lore.kernel.org/all/20260519-qda-series-v1-0-b2d984c297f8@oss.qualcomm.com/
>> RFC: https://lore.kernel.org/dri-devel/20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com/T/
> 
> So this is a v3, not v2. Please start using b4 correctly, so versioning
> will be kept instead of faking the numbers.
I'll correct the versioning in the next post. Thank you for pointing this.
> 
> Best regards,
> Krzysztof

