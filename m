Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2985C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113C610E848;
	Mon, 31 Aug 2026 14:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="K269S8Jb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J3r2i2Bi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3AD10E848
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:13:48 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VB9wPF3447064
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E78ibfppvvm+3TfkUryYoTvM0UqQpmxLebovV8C4ws4=; b=K269S8Jbbty1RrDC
 4bAQ8DH1K9WJrF3+VFDrmx0T/+EPPDFh49Fsz3D1vSDqe2u6IWgtJFUrJTwatCnW
 zGJmDxJ7ao+wCdxmgZjmwKkcDwgrx6VRZ0D30k1QuepZV1SwL+lkUUdcT3al15BB
 0gGSFPLLWl50TydZHbzAZuLf0Ax2IEXyyVmoXPOHukJySl2x94FqsQrKVlHGghye
 JEeWmX5e8Z5gpIM+aAwEf0ZCGiNVuGgNVOm9qMZdDfF43UeBQaNdyBwlUHHSpQf9
 oDc3RNfqIZE9L2qxfHLnhkjlq+hsI/asJjWPlYrneLCp3JX7hsQzSzdaReY+AsCp
 QYkdTw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6rb96pb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:13:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93903622880so691972285a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788185627; x=1788790427;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E78ibfppvvm+3TfkUryYoTvM0UqQpmxLebovV8C4ws4=;
 b=J3r2i2Bi3FvwaJ/MdxfZRutz2JV69+RwDRmvuulwKaa73eDtVEq7mgS/yralY5PIPp
 XKso6J3pVeTPZPJVzU0YNsMFuHg0hKkyE4+aOe2DyTpW2soHsapa94qRTOWB22bYldX/
 lOli2RbKF4N3zlElQ6z0EQXYqpSUrlsmIqy32nQ4MvGsCg1o5llFoRDjkYZRWJzcU3wH
 Wt3A288tUFohMqCqnD/yewTI9xaDeSUOrfzjqTf25U/HyRx5pqS/Te2REQryLtoBcYux
 rmbVnEALJjRXZSVfRvaM7kWNhw115IORpfUYH1EqeqjUY30wowiQ5Hyo+LVuvm9AB/dg
 PddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788185627; x=1788790427;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E78ibfppvvm+3TfkUryYoTvM0UqQpmxLebovV8C4ws4=;
 b=E0eKU+en5qCgtTX6yJ0ZV/JbTGJQLUMMI2jFotlo0a8MsyRGEt1+nYh3trFy+S5qEd
 sz8xOa9K8tHoDdWywu29/IYJ+d2I+SDJjJciY11BJ0/VqEp5/v/tOY7WDM/5Veq1cZHI
 GMTVejaiB4QpRJ6usJIBaSHoSPPWapZhYps/rMfI3cyI+Ht8Sw4ACOLZgruvYOEaoC9w
 0DXCAfnvZaLNOzes9pJ1dcaruGLavClZ9qP113okAwM282e8rPmi6gp1VxDDspwYz8tk
 xjPKmR4vbsDe6YlhfQH0qlAfVtppaUc5hYHuxkPnQIFnr4pHRnDlI73P9mx/u47MoSYs
 dS/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RreNAULasb9nANryYYFXj4Yx7P9SmsV9RRoGWPOPX/KlyLgfCwFoYCjqQGbGpbBHpbGaK5ie4WvTh0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n8yYM3yRKYSO417r5w0uY5MjpyUvfq3BJrRiy+8Y6Wl4JygNgG
 byvLib7/BsR9nSVNgARawsGTwP2t+RsTvsQz2veRp9ZIU7wtxhpGOX6w6LASpLZCG9xwFbhFX/J
 ctWbQSD5SHnF4pGY5PsTgvfKJFeuxjrfwBNP1fsfqPbAxDB9wXUxMWlWue1ddjAEO6NCBhUk=
X-Gm-Gg: AR+sD11r7wc57TcuiYuN1pTDVBDIWAX2HUVhzSnv6fmGJQWWoMVu0naHB0VGyMaqshF
 UvRKY6I5+uw6l5g/9sATuz8rgA32ICoyEh1B4Mjo4Jpz1QHmJ5VZCkza4IQVPNo1XvL6ld4V/Ii
 6rRdyhAOA+ikDhUadsmTpkEGko1+CpZy2Zaq5YojtIGU3mbDcJSJhAR+VOnuh0EogJhR2u/kKBF
 Sfbwy+kOdtnBwxNwb18dsCSJSSkSY/1Q+UUQmbIAqB5S+Y12VaYNjA5oBrHZrQGoASTnLXFZCMV
 oVlT1blMr6h+shm3A6Jh/96n0l+I0nXn1MUo1/nlQT5+vFxWnYl0jUJGWqK/ZvWwdP1RT5sQHAc
 /UaDSGPAf/CJ/VzvjSIfYhaB+ZH8s
X-Received: by 2002:a05:620a:469f:b0:939:319f:d6e3 with SMTP id
 af79cd13be357-93936bcaa24mr843606485a.5.1788185626863; 
 Mon, 31 Aug 2026 07:13:46 -0700 (PDT)
X-Received: by 2002:a05:620a:469f:b0:939:319f:d6e3 with SMTP id
 af79cd13be357-93936bcaa24mr843597385a.5.1788185626367; 
 Mon, 31 Aug 2026 07:13:46 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee7335asm429888266b.27.2026.08.31.07.13.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 07:13:45 -0700 (PDT)
Message-ID: <d95ff41c-dd13-46af-8836-e93ab0926288@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/DO NOT MERGE 06/12] dt-bindings: display/msm:
 eliza-hdmi-phy: Add Eliza HDMI PHY
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, vkoul@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, olteanv@gmail.com,
 dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org,
 linux-phy@lists.infradead.org
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
 <20260828-drm-msm-hdmi-eliza-v1-6-67843277de17@oss.qualcomm.com>
 <20260828141031.CF3071F000E9@smtp.kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260828141031.CF3071F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fyRKMyvpX0EMcTE00D8QiCnyESc_bgBi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX6RxHmOKBlNeY
 Iwus28vKywIRriRjytovj8fxIkCyactbZCoEg4Ff75XGKh5nVzRBU9I1BqD87OF/QGC3XxLHp1k
 U6BMim1Q9EX/RePuz6oQ6JIiya4NNvHT8aUBN1DSC+jRhus60A9MlHwsFZ/guUMSqjtJY/7LoiS
 UljgHdKcLM69tp++frmJSEwM1eGMfRSbwlSmvb7zB2uctV5UysxJL+/+0LNbf7UE+ZAIeBx+bVQ
 WDxyXlkyjU0cYAPZPSpCzpG3TOd5a4KCYF+SiW95KVr8lJtQaCBCu5itWuVQtW7jmFxZWSjE571
 D/r6aJ5xudJtNvyENU3bwvbXsxm0HvZh8JMlcaHWAnkQd07Tr0uWS2N6v/IU6phK/ft083Vk6lZ
 uvaKhEPAiqW+j38+nqCazpLGUs4VciCEuqpxMwreHxfNp2P/AuGWnhBfQGbKdOpcFQw6Q+NUtFm
 4Z6TokIS/xk+i52+z8A==
X-Proofpoint-GUID: fyRKMyvpX0EMcTE00D8QiCnyESc_bgBi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMiBTYWx0ZWRfX3YGl2museVJW
 DamQ2qjTKdbcfBJeQs/h9FWk8l0+Z7YSnMEkmPtNGYINxBVoFPZM2el4fheFDXMzSuEYhwMKo8J
 B3S2lweRDpApnkiRBuirdml6gUdf2QU=
X-Authority-Analysis: v=2.4 cv=d/fFDxjE c=1 sm=1 tr=0 ts=6a958c1b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=AWiUa7ILvgJRdtSgjkkA:9 a=QEXdDO2ut3YA:10 a=arBHhYMabMMA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310122
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

On 28/08/2026 16:10, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Devicetree unit address mismatch in schema example.

copy-pasta, ack

Best regards,
Krzysztof
