Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125DACC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D8F410E134;
	Tue, 13 Oct 2026 18:49:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 176BD10E134
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:48:52 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69DHQmlM1592443
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jIQDQKtQTro6A7rUte5OR8HVE/aHunqAOpl0ebYcwCU=; b=Kn3P+sjV+qBx27Ts
 h9J60XNRISKYnG9cE3lzCrJ54O11ukdL4JCF/+ki0BT7mUAleT9TvnwveMGUmqyn
 LtRdTJTlwE3uvmObLX8LRmMLoRkbz915rTjY1I9OGO6pZ2zQtNz2qyLN0fomcDyF
 qPddwRwyk22lM2MDWR4nyvBpSRazg91XGp/RuldPuZV55H3K3vKofaxXfjOah/Gx
 8uWGQ/wegJHmkW+M/ufexofhIVeTwI4VksWQx4axZ4O/Qjayl61ZSAXGM8pkwiw3
 VlRCzLryVoXTvS7ngzMlFDPHm6wdXam82PwmCPuj9/Ur0WveUIWDlqg8YSLWJZ4a
 XCrkrw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s1tgdtr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:48:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so6857069eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791917330; x=1792522130;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jIQDQKtQTro6A7rUte5OR8HVE/aHunqAOpl0ebYcwCU=;
 b=TssTCwzxFZPiNs/ze1ioReHBC8p1IZIlV/Z0dqqtvYdN9P+5Hut7As/ez8qPVQRSQn
 h/RwnLB9VT0YZboLL5+yUY/XfNttn6jy9tugkclyOaMXM81A4QFMsA+hhad4IdxUn7e9
 SR07eH8vBG18CJkd6nLtWaYw2GYI4L2MUHAeQ4HQyAVvc8Hl9ODeDyH6BTiBmGM+xcIK
 09kpIGI4TX/6SFcg2QzXt+4Xc7RXCDwbnVY8pFEvhOVCehSNtNLAoIZj7HqMUF8NNbYq
 zqc78quVUBhBPWFR0Bl2yu5aUDHkAjGo+qOF8TJ5TdbFFgTEgukbtGNfL8U2NkxmGgXn
 OVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791917330; x=1792522130;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jIQDQKtQTro6A7rUte5OR8HVE/aHunqAOpl0ebYcwCU=;
 b=OXiwu60owQ9oInKch9XDJfyW71kZwyd26J/UOkXy6254Zu6Jk+SbLAZmVWkeN9xw+O
 FAJkm+3OMy5f0du8V6xZd0/GjqbpY8vHHYSx2KZtdvCkF1t/rvfSEpLvBEaXjvD00Frz
 KBvlce3aXqwR7dCWw++tSOvSH6hdXBzT+L6+Zc1/D8borQpzCefV66FFnhi6wpVKIdbf
 PwVDPFlUPdz+LF1e4eOslwbFXQktJyXl+1g1s0DuMvI1cl8hdHznle8L7tgkDpLQeer9
 X477HX/F3EHSf9AS2Ac8HM8bCYMQ4C4imElPirnIyGUOk5hn7gTIbgIZh9ngEQMTzicD
 bN+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnPpkobVj24yR6XYUHHekROruI58LMoDPCArvjNMZuQn4oETq4T0lDloaxeNpuqX/Or4YJf883t9k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKFxXnUfXq+BUplzUe6f92lKJM5xS0DnrpoDjSsV5JzT9IK+Zr8
 E2r6QFCf45LywzuqD1uZ0x2Wr3yuH3KA7cjAYOBP9KhEjcWgVkYGtsuUg9vbelGHeg0slzBTrxp
 QEOSJeBeUT38BaTxt443F/L45NuZRJfK9iohYqadZyNMRnoWP7SdioYFLCerErX8A0ZYToDg=
X-Gm-Gg: AYBFou37gfc63Acsq0itF1VioLqFq53pKjWbGr+WCRFvCagIGEnV+75Yh3R11qOg4sf
 XbHRV1TdDJpqaaaoyurKFrRfb81rcJFPTpHNMU1/gSqKr1NvV3xbVUVama8z0xVSnNvnSo/NVuP
 ZSwwqwoJAIDQUQNImkx9GKda/wtbHiQkleET+LYQnWleT1jDGbyd29D1Gp3G7Ei+BZ2DMjQGWdm
 37i6BtpyoI1T9ko0HXgNfi1VqkSrjTd5C/zAyqaW0KG7ya9alt7wHdX0P1mHH/T/HofFtXvJToM
 LNJpE15q9mqRy5wEW9lwPmenAkUWfoztcArm0cwKok6pcnFWilRy/SUKEQF9ZomrsirHWnMzcWB
 DVEw9I+kLQHsmkU8zrBPs2nzXv6dGSIaRSt2z3k/nYoIuju0Yxw==
X-Received: by 2002:a05:7301:4208:b0:353:5c6a:c8d0 with SMTP id
 5a478bee46e88-3537e2dbdc1mr16883440eec.41.1791917329820; 
 Tue, 13 Oct 2026 11:48:49 -0700 (PDT)
X-Received: by 2002:a05:7301:4208:b0:353:5c6a:c8d0 with SMTP id
 5a478bee46e88-3537e2dbdc1mr16883399eec.41.1791917329136; 
 Tue, 13 Oct 2026 11:48:49 -0700 (PDT)
Received: from [10.226.59.182] (Global_NAT1.qualcomm.com. [129.46.96.20])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d20dsm48905293eec.12.2026.10.13.11.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 11:48:48 -0700 (PDT)
Message-ID: <64c03ba1-7f44-47cf-b82b-43b11970939d@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:48:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/qaic: Add support for AI200 virtual functions
To: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>,
 carl.vanderlip@oss.qualcomm.com, troy.hanson@oss.qualcomm.com,
 zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>, Troy Hanson <thanson@qti.qualcomm.com>
References: <20260831135008.1418190-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260831135008.1418190-1-youssef.abdulrahman@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IpOL47/g c=1 sm=1 tr=0 ts=6ace7d12 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PocSdXh09T82xRbmK9gA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA3NCBTYWx0ZWRfX8SbKcIT8UXgG
 aDf9srvjZsNnK+YjFAKFCUH+d4ZYeo3uAO+9orDocD47amY0lXCf1yn9v4z7zqklw4Ddos0U91+
 6hDKUJXI0lYAp/J07pQMR7th2lzE6pYiGlBTSy+lWMQKCQ3lPciGCpvo830FOdr5l6JXdwKPFnO
 NH7p2dzjsZjcnHfQ8Ox/kEgueUf+91NXOu/f5Qf7eoKm3qzAAGXnyZTGrM/fqj0D7kauRpuebHv
 PqQ/T35NhzZ5ihLd1qVrDJoXBuwwQlb1O448T2AYl/jHajoApBK0jsDKJVL3FE2Sm0MhXwadjZT
 7E6IIwx6DH2hBnamb+ElOrFWXXUFaxgeaKYtG4uX558CFwso6PJ7VvV3DHteuq47NCwNLVlwRuX
 43L7wdzdw923IiYpMtTWXuTZc48Z7e7zon/iJzN6n8BhFD9Pz9oBjLZnT1J01Mk2hk6otnRCM8B
 KLf29qLrCeU04lW3fWg==
X-Proofpoint-ORIG-GUID: hO7oXj05R5qsLs-DN-Kc-iMnDnTTkQ9i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA3NCBTYWx0ZWRfXwh5dr88RvSvM
 39EhF3IHIi2t5hMAeW4XdOKNPtW/T0Syjx9IyQunFlN8zmbtfdjywuoG7W7hgr1SOccTRAgnIVX
 tLAYbSFAomQuanBHU8lGuS6bws04Iyw=
X-Proofpoint-GUID: hO7oXj05R5qsLs-DN-Kc-iMnDnTTkQ9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130074
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

On 8/31/2026 7:50 AM, Youssef Samir wrote:
> From: Zack McKevitt <zmckevit@qti.qualcomm.com>
> 
> Register the qaic_pci_sriov_configure() callback to allow VFs to be
> created through AIC200's sysfs numvfs entry. Additionally, define
> a new MHI family for the 5 channels supported by AIC200 VFs: NNC,
> Telemetry, IPCR, Loopback and SSR.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260814165907.C76841F00A3A@smtp.kernel.org/
> Co-developed-by: Troy Hanson <thanson@qti.qualcomm.com>
> Signed-off-by: Troy Hanson <thanson@qti.qualcomm.com>
> Signed-off-by: Zack McKevitt <zmckevit@qti.qualcomm.com>
> Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
