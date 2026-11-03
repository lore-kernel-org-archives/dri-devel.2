Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366FA606A334
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gg8cOWh4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cvCR4cg+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC8E10F715;
	Tue,  3 Nov 2026 16:55:48 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0059110F715
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:55:36 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3EA0L03047900
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 16:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IaNvP2ADZd1IStvWUxof1G+jxFWvAANqgFbFfWV09+w=; b=gg8cOWh43V8d0PzW
 gMZC25/oL2WJw2pJOW7CxIj9CRm4/FnXIFZHRrBpad+3Qi5e+t/g+IdOo6KcRbk/
 nbFuOn6zaNsOBa3s8DjQ43vloXARSJQVIKESdSPcw2160IbX/YRyTD2LgihE+ZCV
 ukoprG6lUzbexQtX96uj/pAMuwP8W4vSdru+//OIYnlYiJmaSAY4tMsWyKpOmJ07
 IDYQSPrFc2nYyGAUXQ3RKxfiCBMrZKlv0bt4xxhz+Cd6ghCAQlu3jCuipw1FAcCk
 7h6wyWrpub/rp0zLLVRrJEteyUrBYbyo6rZBeLQ8pYSsQEj4o1bLXvIXSA35HB4r
 nu4UQg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5krwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 16:55:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3552883bd19so2536585eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793724936; x=1794329736;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IaNvP2ADZd1IStvWUxof1G+jxFWvAANqgFbFfWV09+w=;
 b=cvCR4cg+u1bkvG38sFzwr82TwCsfwyKl+CicswZCq8V/bFCIf5/ZwfqM73oeRwxaVD
 PrCH0RdTiVKGQynCvOBi7ATLZugt3MdBqqhmNSLdcsChUaFbfUaxH8xYBlgLPsSBJ8D3
 RaionAF8xObQ5qNYRnaF1xmE2+WqSMD9W3WtKSf7gCsFesnM9DrMRgT2khwQ39NpPtfN
 EPZljB9dVbFF5ddb7s6XoUMuYjG+ID9YuSl/Ce4yc1E8CySr+T7xPwCh3oEOthjEsS8Q
 5WiKbEDV7r0i3KNeS0nVm4lM/Q2DcaYsjQWfVIl6DivrpI6/FWCeBhi+xAimtwYLcCWR
 0kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793724936; x=1794329736;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IaNvP2ADZd1IStvWUxof1G+jxFWvAANqgFbFfWV09+w=;
 b=K/YUI6yQfKj+KDdNw3ysdMNrB/nZQHehPFCq+z/k8SmiHQ43Ow9efwYiZy8OVDBc4r
 dTJeMnPRW41pr8gIRDnkwmG2PexrvTvqlZct94wIDWyIH1uyfA7ltz2VQQz/BitH1D3u
 YyPpHK5NSCzJApRSSLPac5EQ4+pw83PgnOP3Cfp0mJampsntz0T3nph+rdhGrKq1HrlB
 tcxH5tWRbW+Yzj6632wMFNlblTG1ZFzsamxaRFuM/hcKjq+3ynBPHNZpXUbomAxykwYy
 v4vsUs/HDkYBG5JQgjljOvvuisdms7gZ9Dq3cs7ZDKDvWAHFvLn1m7EVEi1bEmyE7TjQ
 v2zA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwoROPO+FRRIPzpzf4OEABZCG6uk5XKVue8v0qLjdl+IJdjpEf9Ei7/B2WCqUJE/EODXJLbK/KXlO4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ZbzCxr9Az8/WhPC4T51FuIo6cKOd9zN93YYmVF5YLM388Zp9e
 jdVnSCZ4RHROnr6XhN7uLUjIZWb0xsbqWKjymB0+/cHbXsa6SX0+h6U0lNWinsMnbSQ/8Up9OcX
 0IDeUGcjm+pb+MYZ1mWJbPsMZS5Zbmv/AM4cTmomUkPat7jl00GX1f/fbQEzYRDJrnBFp4go=
X-Gm-Gg: AYBFou0FrE38XZg6d/gwbonohPB/sF8fcUflrhuoM9i72Al3Q4vD22ysAC8/GMyFVnK
 Y5xU8S4FfvXTe878WFhKbI0oJDCK/mfDzdxlj77Pc1ids5kr3OB7Xn0yJRwC6VMlftQWGbpxXmc
 4j9sYC+el85Uw4mGgnv0F9BN7Flx3gxrjzFh5Q03NCcRQZ8GlCTDFqNn8jMozgQnTa8Nxp1bBr/
 aI++g/k5zaKnciwYGMyBMwzwmX0rkOcGqDsMd1tPhkD+LdxY4JwPpawx2xcf9YxnoLtecOAXD1t
 W2lpHh/ln7CZ+SFMmoKlpUjzSyc2CO1hQ6Cg/nPeXPQUbhLtb/TSjufVKS9y8SJXVDkOcNn065y
 IJp/zyVYNGdeBcFAiinECGtA82sBqmtc6TtRqZ7je6N01rv8Ew0Wt0g43zlVr8G+k/i4iscCu+n
 gIxcrVvCX1qtbsjoM532rWdw==
X-Received: by 2002:a05:7300:d0b0:b0:369:9eea:cd25 with SMTP id
 5a478bee46e88-36a4235f6ddmr20112214eec.7.1793724935539; 
 Tue, 03 Nov 2026 08:55:35 -0800 (PST)
X-Received: by 2002:a05:7300:d0b0:b0:369:9eea:cd25 with SMTP id
 5a478bee46e88-36a4235f6ddmr20112168eec.7.1793724934818; 
 Tue, 03 Nov 2026 08:55:34 -0800 (PST)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4294419dsm46918707eec.18.2026.11.03.08.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 08:55:34 -0800 (PST)
Message-ID: <9676db68-3dd6-4ade-bc50-74c4e1172b07@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 09:55:33 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Replace profiling frequency debugfs with test
 mode bit
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 dawid.osuchowski@linux.intel.com
References: <20261103094215.1245113-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20261103094215.1245113-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zczzWQYZ85l6lG-n_WIvDDbmf6v_E7S8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2NyBTYWx0ZWRfX5n5UnCqiFpas
 EweSnDX/yWU50D2QLWic7JXAoyCAOVgrPu2A8H0R1eDXQdtEDVW7JN6bGdVqk6GPgblKWekI79a
 dun+2J1mfzcHYt9lAXXximX+FLmQT7cM520EvodIU82+9nuojExltZ1XUKeEdz1IQuy+H3CkIsm
 1eYmv25TTcMSw4Br2Psm1rjbLWH8TLg4o/ndFbmxtX14TLCXkvJ0gGVrPZbiB9Hqr+duldOakHR
 Rp8k2jfJAlC48yB/VVYnTe7zPWNT6RJ1qsGGGj4p57HifHNVg3xw0JuD1zLK3BIhLsUlh1Mqe3S
 SgHqibi1Auv4zFxFy55wJT9WIYmsfJvQPL5eWTrtxY3rOSSuw+/D9/Ry3/p4FPuFNXNhZWZ+m9Z
 hl6OjAXNGMAc3tKwu17WpJ9GoXhZjt6d8KBJtNErukJX/XeplXcrGxRAgwLW0WQfyvyKARs9qUQ
 jHBdR0/nvOFRPLFYl/Q==
X-Proofpoint-GUID: zczzWQYZ85l6lG-n_WIvDDbmf6v_E7S8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2NyBTYWx0ZWRfX6zhek4vzi1l1
 jN6uHAK+NnNE5Dld9UFG31459PemxRHaQA6qWbeFmj4oAS6A0w7R8PD3914J6Kb3O4LsfZxtoJX
 FodGYVJtApZgFdjln4E3JP5ovqbKm4o=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6aea1208 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=cS90iRxaKYjfw4SDNZUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030067
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/2026 2:42 AM, Andrzej Kacprowski wrote:
> Remove the profiling frequency debugfs control.
> Add IVPU_TEST_MODE_PROF_FREQ_HIGH to select
> PLL_PROFILING_FREQ_HIGH during driver initialization.
> High frequency profiling is for debugging purposes
> and it can be set at initialization time - there is
> no need to control it via debugfs.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
