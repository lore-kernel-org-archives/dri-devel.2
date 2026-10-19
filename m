Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E81CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAAE10EC82;
	Mon, 19 Oct 2026 11:48:22 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B73B10EC83
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:48:10 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8PDZJ2193411
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1IVpmXKjPqO0ciTUQvydqlwZmfEo3zdqJh9QY38OJqM=; b=BVLQgX2G4+5ibb5z
 naNpvmFbebPYybUNIVsEbdMOcPaQtWO0TZQgPPkuEM5Oe2Flb0vJqGsT3qQPjNev
 fIFxxMJtYJ0YTRcICEBq1Um5HlLABsEAT88Rk5c/h7PMzBvVnaJvhmK4acvnE+Rb
 hDz5F04hTez5KuKKe0jQMfpG0+uprWJnuyKyxxql+riWqDem/iIv1lMAYCCezd8f
 rCyxZOcQzaXomi0jNI+/Bi1HnHRUQqZMshj29rnCENYK+o5lQfQmqaU3T9CTrDcn
 xC3LRGegAvzRjHTZeRvYPxJYn3UGQFVvn9N6R/vWBv5Q9YYMWdGzx9BwNPGmArHA
 i9FN/g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5w1ahuk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 11:48:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ea6b66e53so35297585a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792410489; x=1793015289;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1IVpmXKjPqO0ciTUQvydqlwZmfEo3zdqJh9QY38OJqM=;
 b=TWfEJpfF1BHPkNOwCrJMQny+YgH5IlOs26b+Fh4RODfHH4g9tuQ/RxbW/OnjM8QGQV
 W10Md2bZAH8PjR1d+v/wSvmgZiXpfOsEqO0sgJ3fnH6HtMweVUK8gjzNWDFjpgeumi/N
 IMm9UQMhZYKNokrB6iLY8o92ebp2DvRyM+K7sv2+5VEeCP501d8UwSxtJrpa5CU2cyaX
 qUeVsOzyJ6MIsgBWHOrCCAp3rgb+qMkNEwDQ6Fs73q+ZSLZ/FxXsqGCpa+ZpqX9RAK9r
 R6yNWk8OVKrXmFVThWvLW22jho9eZ9VmZAx2s6zz2AgNad+uZs2xejwCzPy2iqa9qnSD
 C5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792410489; x=1793015289;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1IVpmXKjPqO0ciTUQvydqlwZmfEo3zdqJh9QY38OJqM=;
 b=LW/CJ6swP05K3N+DqMGBppYNkvkFIHfr4LIl9rh27A4zUZEpWKLVrNkUQzKkvJkOd/
 4q4E7iWPDs+PDzN9NrTOjoh12MJifRZHRXFtSfx3dodHl9peahd57MAtGlw9TAGfhBon
 xHYODhS4D+9dyyiORA/4S4CTnaH68bzGpfU4LOft5G6U3yFUDTuTeyNXVY5JmfUt/2xO
 vu52ieiG/Nk2kCBrWbXcqPpOr9+F2fWRh4A287EylGRnvj9p8G1gTECR/5Qx7uu8mQij
 eFL+uqDjqUQoFW1a9bYM35lNyd4IVaNL40tpYTibl5dquT9VaAXcoKTTxy5ejXq3de1k
 jXkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpzdaMsPrC8Z5tEwe7F6Cd/qBeAT8FQXut0XMkHzNMXNiGlgrHnYmTeTEF4EsEItIxCXNUpD0B408=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJjY5u+4OVMtEhBfcQi82YNEf5JyQ0wCIdooCgrMl8TNG+iA5tM
 Elf5eIK/Qpw2gZ9Vu+ywO1ayLa5nHDdU4MI2eNrt4vw3vjMdy0W4RnD11gHVkob2V9uf9I3fbo3
 29ZvbwPz4pgSxmcq64Kld4IPePGFtw1y2GNOEDgtxOihPhYB7qQRCyb3qZsBKifwSjY2EDTo=
X-Gm-Gg: AYBFou0z/C82QgtA8YwXd9d3hGsXU2IHP5VIx/Qtsl3fi1BedPra39RCHTZjTOtGfof
 oXU9XhPOv2WrnpxyNqrHrgeEbgedYybkIqlq8eTCysuZqg48IcoN8EEhTx0Pc3UzvrtVdC4e0O7
 R9eKeHT05fo7sBViTD7/61sEUW7QCBW+zo7wY5j4qau/uz/69gdr/aPoienmxfJJHMRShL3mm9U
 g4sG1Db3dZ+om/dK34VqNGkDmjhIRo38umJNAI/gfXaTMzFyPM6aX0LVdz41q2R4WQ94VA5HPE1
 O+u3ByaWYbOuvSfIR65OTMPyqc5DK3PqQ+HQRQPWXHxsnNU5pFyv7OyKdIQfqVrBfzlklm0CrTe
 F4P+EYvxJ0F0iveW826VM0Q==
X-Received: by 2002:a05:620a:6192:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-93f29e50356mr1367152585a.6.1792410488816; 
 Mon, 19 Oct 2026 04:48:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6192:b0:939:9ef4:79eb with SMTP id
 af79cd13be357-93f29e50356mr1367147685a.6.1792410488269; 
 Mon, 19 Oct 2026 04:48:08 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4090dceb9dsm347362766b.24.2026.10.19.04.48.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 04:48:07 -0700 (PDT)
Message-ID: <2f63cf93-acae-471c-990a-c844185a9db4@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 13:48:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: pm8150l: add LCDB regulators
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Kiran Gunda <quic_kgunda@quicinc.com>,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev
References: <20261019-sm8150-display-card-v2-0-86c05068efc5@oss.qualcomm.com>
 <20261019-sm8150-display-card-v2-5-86c05068efc5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-sm8150-display-card-v2-5-86c05068efc5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX9qkL3/VwBDMq
 gzc3Jz0wCOtayVIDdMoMveJRqTaSMln9qI2vLDXVQ00taTG8nUtbEkzct+Rtt87hxTK/KifqcEj
 raMq81jGLJ9yXrz/qzvIe1ic6CUalEA=
X-Authority-Analysis: v=2.4 cv=KuPYSmWN c=1 sm=1 tr=0 ts=6ad60379 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=R7n-rOns-cfn4W1FH0QA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfXyeMj6lCUGaiX
 0mV3M5GHNGU5dsfLVL1J8a3lja/8sLn6/V8E5ZEdWfuUt2OfRWYP2k8rWAYsvQ5BOhs79/xlsME
 9qd+4eNbn7+xum18d6UYTALxrgxnOjOqc5dXlUo336RbupSjXGrd2P0Vi6/lrhwbfkKSicNqorv
 FevbG56TUJPw27y+YbCAFNOqfzC+zdpXwxEv+74KcQI4G55bJTqIUox0ebrTlEx8Pc0jaXMnsls
 3SzpE1V+0dJH6poKyPeda20irS36IAGGtJmZzcHrwKVpe3kAMKKTYCpT5i5KXqynv+7bVejQ2fA
 jdWUCTfr26u+3d5NBFHQHpYxHzNIQymam+5p5Yt9aMVWGAuOPoF0fdNlDTzv+lXOSZPO8yVcbi2
 wdDEYwxBf20VLdZlg0GSCNp+ePisTjTKcQeRCjwCXb86A/0FkPx1MCsOjqjvUtyhiuNb5iX+802
 vSVmnSi7zbu0yLv8ATw==
X-Proofpoint-ORIG-GUID: TqvdzaKcCSFDkX1YGZrw8K6GBQkuXsjm
X-Proofpoint-GUID: TqvdzaKcCSFDkX1YGZrw8K6GBQkuXsjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190046
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

On 10/19/26 1:25 PM, Dmitry Baryshkov wrote:
> Describe the LCDB block providing the LCD bias rails. Leave empty
> regulator nodes, forcing board files to provide correct voltage.
> 
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
