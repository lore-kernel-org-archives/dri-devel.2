Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4840606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p2u9ssez;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PKjnq59B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0963E10E0C2;
	Thu, 12 Nov 2026 03:02:36 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A3C10E0C2
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:02:25 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2Zfjj3812899
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YXD4Agrm4CLDZ6F9wgGL8OXG8rmJ8G9l+pKBughaSr8=; b=p2u9ssezkjwxBO+Z
 aiJBc2ky2Mckvq5XcTchYc2/MHdO1bxeSt3uhFIxQuNhzj7O5ijPf2+nkxb+62dc
 wXyHdwp1QaPvLTflFmSurrS3vPN48/EV2OPtWR/gupkoe8GPZRS4UfqWUk4G//NT
 fJJLyBPNArdtf2Sty+R5PpthBlE9zhdeAxSOPRsilTK/o/I2cTLP1crBIJOw/KXq
 8U9DAhZy/BuomdZ06UGBTpvKG2FP20Ubl7wJdE7Q2SBo4w092IKZkgXZhH0UjlIR
 y/x1aAIZRfego7/q1AcICOqOdvVfy4haGUWl44sdSDEjQ49tL8ayR6lCzAZWrCyM
 0PtDbw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvvw0htt1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:02:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f37c94ceeso92130585a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794452544; x=1795057344;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YXD4Agrm4CLDZ6F9wgGL8OXG8rmJ8G9l+pKBughaSr8=;
 b=PKjnq59B8sCQFguNXN1JUx0cYhtmS9isxB/obpus3WcG5IHfMak4geOBJsJrE5bH9C
 IR4a758Y6JDY+U2Rr4Oy0be7B4HWvZIfQ09IAODYjlqAqVho0vYPDlWzhKbenJt8fp8D
 FLgXyTYhBFb5AolJuBPuGETMF3W4qzrdgnilS5xgVFZBHPOU8vyPvFMd0fJt1SEzdBOw
 PTK5/YtaYn4a9ql8twHVu7IDshGCvjRYutYWDyCmu9nNWe9NLLUJo1oWyfrETIjj+gK4
 9ug8K4dGGqUKzExyIjszmRvlksWmmIw3Tep32gD8X1YWmI+BVJ196GrgaJEbOSD5Zr2N
 Mkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794452544; x=1795057344;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YXD4Agrm4CLDZ6F9wgGL8OXG8rmJ8G9l+pKBughaSr8=;
 b=DS9sbjn9c4kqoD4CXtZSki8+u/PG6uJ7fVDfI+c0cZmaQroXmjdpVGkIThyKGv26tq
 Z341Gs6j44YxBZGn6nZZH+MzyHUXJ52RJ2LvadyVYwQ72bThctDa3Fi17cO+TxoqONim
 cizAZ2qRq8ZY29EER8YO5T3dpE8VEkMyuSWFYIgxe7uQlVN6VjSSOK4G5FQZbYrPLRsd
 5GpxfgqQ/RHRiWrRSturQBZGV9ZZjXW65RCLkyZuKs1OeoDSypKBjdw65uHhA9qWCU4s
 DITSWAQ+K2h3cht7DcC2wimTFd3mAmYdWEJAw4dtKoNcwoAuog2oDqAw18T739SJjwuQ
 MPXw==
X-Forwarded-Encrypted: i=1;
 AL+hErEL2UeJt3lBSOyJn6DCPIp0Fr0An38S9tQy2TJga7osg0IYxOXVn9cc3U/ExppKqz0vj0S9CRI5xWE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+N8f/Kv4IQYoe3J8RHYuIaVji9Ie81yloMPji/KQt21RknwLa2
 mli2byiC6vdHYbn9IUEWV+8lf+86R7La1bh1mHRaQ+sw6nZ3abJU2B5rptLj2FOfAfhdTTfRcGD
 jHSeDFQz0mN88pDsY68F61JolPN8vJSja91MkcUqcAM1hetjf6QkVuMeYRYVdotedtaUrSLg=
X-Gm-Gg: AYBFou0mJyIlg7tnzZHqwOL/phu/0Tl4NR9IbLVvv73XKA2eoFWkOKgthhseaUxqGe+
 5b3FqC7W2xRSvUoWZ3KnsnH9I5AQ+dZf26qdsvkWlrkSjyHqCMR4GSA3IIG3oghl7vXncnctmmo
 QP78YCuzCAZMtjlZ6U3IAAnMKcGVlmcCdtyJViXwe/NGLNWpy/TPypmlodCk2UYTm7pO86I1SLp
 WUuNHGkFFjMIqrNgP7BgEC9xbgoue2/VHrDViNz/9J6AlAKF1GJWeQYe7sUObat+awTlrc543KF
 kqX8CbadRn810ueS3gKJTDjBBaomwtdvuqE9Q0uplkE5OHoyZCV8mYVyMo+fzlP1IO60AU5p/FR
 bFuZe5SknpNsxHViuYaYz4Scu2NXtVlw1yKuYIuoJ4/ctlhFrtiwfu6/xfiCiFJQVidiFstQmpW
 WanHQx6Bmf9dqEymtteSoq0wM16g/QoWQ8YXiYqp4=
X-Received: by 2002:a05:620a:4142:b0:93e:7ddb:4ee1 with SMTP id
 af79cd13be357-94932e1d17amr282168685a.31.1794452543778; 
 Wed, 11 Nov 2026 19:02:23 -0800 (PST)
X-Received: by 2002:a05:620a:4142:b0:93e:7ddb:4ee1 with SMTP id
 af79cd13be357-94932e1d17amr282164085a.31.1794452543269; 
 Wed, 11 Nov 2026 19:02:23 -0800 (PST)
Received: from [10.111.167.254] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e7e3c34sm626765785a.36.2026.11.11.19.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2026 19:02:22 -0800 (PST)
Message-ID: <ae255a03-deba-48c0-a290-7cb0e50b10fd@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 11:02:12 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] drm/msm/dpu: Attach CORE and INT2 power domains on
 Kaanapali
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Joonhoe Kim <26rote@gmail.com>
References: <20261109-msm_gdsc2-v5-0-4a3159b5e4b8@oss.qualcomm.com>
 <20261109-msm_gdsc2-v5-2-4a3159b5e4b8@oss.qualcomm.com>
 <20261109-industrious-impetuous-slug-a8e4ce@quoll>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <20261109-industrious-impetuous-slug-a8e4ce@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Gp5Fw7ajXlcwnM_K5KPvumbEfSbJU9ew
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxMSBTYWx0ZWRfXxoxkvkUHCmrr
 awfFaqTr7RhGTf3HnAKckeLLVgz1AvlDsLeU/JTSvcfEroLQBGSYxQBg2CCBrO2a3uA2oAxBQ2Z
 TcG0cMr+F3bZr0SMupF9Ok4f7+g6eKDTCdK3QmOmWFzV3Q2wRgyLuIHT7ldB8sZUbgNCqS5Dpmf
 dqNoUUlMIKZuFP6J7je01GBbQY/kJNmt5vqegK0w3GCR/swVH74/4Wn0YrTZexLemzoQBeT9jKI
 s/Mwu5IeJUCZjCYgvlpnwUBdukUn4xNvRO5F9JrHI1J3EjpalJvnIbYUUPcO//5eLwQ8YjWmmJY
 Dp50NbI63U7yaVcNWrDGIx37RdGzP7Qm34htd4KEtUz37CXv6A5te49LuhfEUkX99yWSTftCn5s
 znjgNmgpeCTqko8TQTu2CRNhmc8Awo1cR4ndosbodkT/Wo3zhuLfpR1JnqVoXA2NcpLFl2jm+D9
 ofrpogFTvbIRLzaHNTw==
X-Proofpoint-ORIG-GUID: Gp5Fw7ajXlcwnM_K5KPvumbEfSbJU9ew
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxMSBTYWx0ZWRfX3bqgH24tWdxk
 INqsl1GiSY+jg+FrqyrKybJC1MKQYi/+WywzjuTtYr4PhOXw7jsKtHVnBkdq6pYDqJIC6YWEu6o
 mxx16wc6bbfHNKyn0etXTJ4bECQH99E=
X-Authority-Analysis: v=2.4 cv=ct8OAF4i c=1 sm=1 tr=0 ts=6af52c40 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=Exsngp9zyEbSqwYxnZQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120011
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/2026 8:26 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 09, 2026 at 04:36:36PM +0800, Yongxing Mou wrote:
>> Kaanapali's DPU is supplied by both CORE and INT2 GDSCs. The
>> power-domain core only auto-attaches a single domain; with multiple
>> domains the device is left unattached, so both domains must be attached
>> explicitly.
>>
>> The DPU OPP table also needs to continue controlling the MMCX
>> performance state. Mark CORE as the required OPP domain so its vote is
>> propagated through the genpd hierarchy to MMCX. INT2 has no OPP of its
>> own and is attached as a regular runtime-PM supplier.
>>
>> Platforms with a single power domain remain unaffected and continue to
>> use the existing automatic attachment.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Tested-by: Joonhoe Kim <26rote@gmail.com>
> 
> Where? No tests were at v3 and v4.
> 
Thanks and sorry for this, will drop it.
> Best regards,
> Krzysztof
> 

