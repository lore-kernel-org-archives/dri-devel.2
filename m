Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4567CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BFF110E635;
	Fri,  2 Oct 2026 15:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XYUfsCoQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P7cMwkbg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF3110E635
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:22:16 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FGxbP2751421
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g2scOWJMHqr7Uimrcomd5qXR/t1WNQF2C5WcasLtGgU=; b=XYUfsCoQseigF5jZ
 rVdnWS3+Ip6Vc1LjYOHzY3ZLGlkoc8W1MQMQ9ZObdEhwV0UT+oJiNMV2AWWuo85+
 2d0ekhgUtuIPc9JyasEDog12OG2ok29GXOoaYUSAIjwe1uiVVfCgGVjPJpVnLPZp
 XGoh6y9gwQEhrvyelt1VyBT3SQJhxhM14nFt4kJsy0BC5MO+NXzjwDrJzmtjsTQY
 ohuAkaeL9o6dygTzfdzf2/L3BLcevqViys/uGUTSx+spZQzWyVjXyaWieGyn8U3e
 K+MegQGkCSl2389vOQcimTAzdaaOiZL9BITKXsN+pGzTzekjgf4l1e/rf7Vp2fMg
 MYU1ng==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256mt45a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:22:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc51591102fso5580791a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790954535; x=1791559335;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g2scOWJMHqr7Uimrcomd5qXR/t1WNQF2C5WcasLtGgU=;
 b=P7cMwkbgeXEllqKk1GG+PwEPwFLcAHx1CQ0lDloVGDcca9i4tD58uXccVm4Lsnhkr2
 KKeqg1K7xxFnXm4/yBDf6L9loZPmZteGknTUNfbS8oIw5QdJsKmVj9IVK1VJuj08HlMY
 g/hC2EgvgSxZXIZq9W8lWw1L5kY2FUjwYVlvYu4YFJ/v0BcYBHevu8BZrnkPfRJlBMjq
 Atm/2zsPBPEY+2cwxDi8NN2gxBbGAiBWFrzLsDdHQjKl3BZJX2RqzJZCpHd3kB0B1XqC
 HJ2OngmE8LA96KyKMbct0Fkob2ss4t+KlhZVJSqzZLvroRgtRTa3lSVOQIF7G9iQ0mic
 cNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954535; x=1791559335;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g2scOWJMHqr7Uimrcomd5qXR/t1WNQF2C5WcasLtGgU=;
 b=Dps+/xpEXUE2w9PXPf9z/wTvAo/z15FxJsGxOLmTTExopHU6DG2b0ZfXUsq6rv/wU8
 VWgJu/ox3F9dQTmsQ5+18OS8PG6urpwV9ah4TtASX5vnV8ejlcEkzNTp+Cyy692BzsNx
 TZU9GDsumqhMAqZNDoa78JnA718MYdUwf+YLb1SXDWVaqh0mio+uMvgtxZazaT46RRam
 X8ZXvtMtuY9r7cowsbDTkRtZDjNvEFcqcy4Q+mK9/IhoyIN/3aqQOZAwxsctPC4syG0i
 ZwbZYTrtTwWPSToGcaABjZ432X+9dKQInWoTJJG99VKrc/80YvYap7mUsh8Ty0s7HCQW
 Gg6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfuLpJVy8XGcnVa268cMmMYpEucpjq+6f46+0b1yovWj9a3VeTZtpsn4QV6k0b88ijy0BeM9/nJWI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nrNofiz1Wvwz0Q4lyVKV3aZXWGfGbZBjMJ1er1MKjjgJeSYVDv
 T7xHgbGEFzQU7I/lEZVEYO90DUe4mptDwSNB6/83ZwbLeOb6eskLcUwx2IS3dCAOEmqdXM+sswR
 uguQgwd4/BATYGD8W+zLvuXDb5Mo/DTbRp8yKnbLkjy/qB1tQEdOH5uJDxTS5TkTNN57UfmQ=
X-Gm-Gg: AYBFou0/rqVDEFZpp2hADK012PK6fP2/AUkUHXVU84uGBEnAUoxiyPMEKW4l8ECK1yM
 46rymZv4sZDA5kJawGVY5e7jTnLtvdomsVRt7NTbIdxeutaaxA4/DNtouo0s5hQQ5LfLAknI4jR
 9cyrfDr4ElhMFG7IEnNe4gz+v49V1sGzuUZnAFdYm/sbXQOjCw/3tODFMLKtbCfIQslojZbzjBl
 OYR6a513tpqxj6H4Bfx2bp1hkx+2o+pGH1SUxoTSJe3z6boLoPc/ecqvbFR9ediQNhTE/IufiO8
 Q2I+Xwx74bzlTI3+svJLoQHzW7C/IOWHouuvEIqiw9hcHh2F3cuBdqfaKSVWZqBWPGheCBFty0x
 BGcZuPMU13LZnmLINVtlLgMrnfh3UB5a83vIsJ6IrWqUiEUnR2w==
X-Received: by 2002:a05:6a20:748c:b0:3dd:9483:48cf with SMTP id
 adf61e73a8af0-3e0bc9f0b29mr3103244637.6.1790954535493; 
 Fri, 02 Oct 2026 08:22:15 -0700 (PDT)
X-Received: by 2002:a05:6a20:748c:b0:3dd:9483:48cf with SMTP id
 adf61e73a8af0-3e0bc9f0b29mr3103210637.6.1790954535011; 
 Fri, 02 Oct 2026 08:22:15 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc9f73557f2sm1149975a12.8.2026.10.02.08.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 08:22:14 -0700 (PDT)
Message-ID: <eaa7b598-24be-45c5-9ab4-27bc87085d10@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 09:22:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Drop MTL interrupt clear-with-zero workaround
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, karol.wachowski@linux.intel.com, lizhi.hou@amd.com, 
 dawid.osuchowski@linux.intel.com
References: <20260930160348.1562800-1-andrzej.kacprowski@linux.intel.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260930160348.1562800-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX4n+UY6R5slx3
 A0CUOyJKiySM/mVBUiqJjABbM6d1el6wJkNCehbRurv9AX5q/xDbrDc/Gw9jCEGR/bm29lDBAAp
 G77OIsbxmscTWitP+AYGS+Kp47K1S3A=
X-Proofpoint-ORIG-GUID: mrgZnn5nY_0cxAVouG75yY3v-bAMkuMq
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abfcc28 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=faZJ-TiWyz3sMHCvU0AA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: mrgZnn5nY_0cxAVouG75yY3v-bAMkuMq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfX357NU+bGXH+H
 JiuqFrmHd639Fnpy31ZbHVISXRaMeZmwQAuFN5EMBA7eW+gAJeyjgsEEZNt0yWORSOQFm9EhPfL
 Lx67BC+Limkx02ZatG1ZAyoHI4OBXjKqhoSahW8oJ9wzlT32WMofaAhNbTgOHGa4pbG8a2S1olY
 0K2L6m00YeM7Q5768qNwtrmDMPdkJucYhCv5vvB3JWr7WBaq4Z5g9/PxyvtuBUh82BrZu7JTVPN
 C5XGx+qFs1kKAXE5GK4hjDVQWKjE46+whNt1gukHYFCGaNP5fACEHei+1mGRX058CbrXwKUQIZQ
 JSI/egk3lQsa66V5iGp3DsYzEYwPqQhJiU+QP0uNQAf6YLiaFUBbfLbLd7DRIh4h7O38r+oBQHV
 1mKttXY/b3ngAAvrk7AydIdPOkxJZbnxibi5dESOvpF3PpuoP9VINWA6i7JlHW4vEd9Oxte8/Y3
 IJ9LCnSJjfEU52/viDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020061
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

On 9/30/2026 10:03 AM, Andrzej Kacprowski wrote:
> Early MTL steppings needed a runtime check for BTRS interrupt status
> registers that cleared by writing 0 instead of the usual write-1-to-clear
> flow.
> 
> Those pre-production steppings are no longer supported. Remove the
> workaround flag, probe helper, and conditional IRQ clear path, and always
> clear handled MTL BTRS interrupt status bits by writing the interrupt
> status value.
> 
> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
