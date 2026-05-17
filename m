Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6115CD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 21:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DCC10E0D9;
	Sun, 17 May 2026 21:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQ0Wogbv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I0z+WGor";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DB110E0D9
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:12:54 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64GNUSC8919547
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=USSppWQenx9I/rY2PKBd31OY
 jPwORwTFfqQeL1QfNqo=; b=WQ0Wogbv2rn73qU9D1bPIfARDwRH9oCxNGSmGany
 1ZObfhqH3ft962vYO/CFm3lJAFW3Loh+fEvyRHp9p80Ca8/yQDfbLmJZko2vFn08
 tKnsNmDEe7EVt5JqJPN9qZ+8wbqusNtW71BOexbeZbR//MJ4uuL+liI4XXgrQCAr
 iMY5dezjKfHXEOsS2HJ4sbj5hs6hjgbUx0PzLobFI/F59rbiwR4gJX1W0UfUHMwc
 tYyxQKmOLOygPz4/iouKFfb1mPKXZowz3dCFT7ajm4ULkAzhGEQN9RL2e/SaZ+i6
 TupvpW7qbdHofbpuhpVDjw0SJSPIEanRXEnREiYvTruoew==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hv7ugpa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 21:12:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8bc5ab12bb5so57615916d6.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779052373; x=1779657173;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=USSppWQenx9I/rY2PKBd31OYjPwORwTFfqQeL1QfNqo=;
 b=I0z+WGorGyL4Peb6j6FmjhT9Gp9kc6ecy9L/x8r4Vd/Y5MJ+x2mnJlx3RGqkOxZfhR
 KqU7M1qdN0tNNoVzqGPpYrHdHVtOpXML436gVXvl4Niz14bHwThLxUmy+5p76Pbo0aYs
 m+cGOsOXJTXkshfiBT8yPWJmFsT1KQnO9zkE0yMKx4ibKrAPrRFtm8/1zylrghPH4xU4
 ENqYFHdGeOmVd819nGnQFuke4zH+HfLjNTOgNjb+ktLuESXlQnMIOR2zUiAAhsL3yivd
 d+p2OCuKDnzKAvUNpQw3BsQat5VS/akEI7dVQkcuNnOTziu3VaPz3TzERUgJJrdnVYXf
 nvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779052373; x=1779657173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USSppWQenx9I/rY2PKBd31OYjPwORwTFfqQeL1QfNqo=;
 b=hadxhxjiFeAFuPaSZnkiS+0BUftXhh85ynw7UBy99kxhewGFVYJmNteCJvr5yONmGq
 9YPiA7OSq2UFzG7TcisNPwUA76fNMxQt3BHIr9XFWIfw0uixVLlFQ3aovgzhGFvAhQh0
 WYUy2pZMzwOBP+HVQaLfPx+fU0RAg0UCrs0IF0hK/mpQ9xe/nQJhA/MQETzaswLe5f8W
 ffOVIqAkl9IZhdc0rdGsZEQvRtmDaJPd67h9cxKEub33JTaeu+hQg10NBSBDeSIKPQQt
 OfseXFuhvh+Pxi2DsVYs1VKtaC/p3KYD0kLUYayxmAZlE9ln2JjQBoDKAncIyfwRkSGP
 c1IA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uIvEmwMafeBswyprzx482XfdESTTCpBBMUneFUv/1xCRIJckJ8fgUggf0eXv70gwCcBDdBBWjhHI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymDw/uNy798gT00Z+4BfTuRrHVISpFakL2AiK/VVHjXevJKf4j
 cqoZ4myQ0WHA3tZKu8c8M6UbNhlMDpnOHCVy1a/rTruhrJ7MNL+1U6nkbg0aRsLVrFLAD0rhG2A
 80ZPXGqED1s7DRrJfbLfheKj24DZlVZl8cACL15OorMbfx9eSisVoZ5B/z7SeEElG3GKrQ9Y=
X-Gm-Gg: Acq92OHAkYqmYmMpU+MDLqiCAD1pXMTdxYClh1/oTdqLr9fXk4A/kG5BvNJlI9cCqhn
 hcY1XFcDCR36eHb46yDqCRXIdzp1Jntutsc+Z8JGNaf+fJzMDBePI+MPYGUh9o8DNP8yxyIUGb/
 RDHzO/0QQu+5iNIZRIKjJJ3K+SMctOX6z6fpKwU1780RbsEaQAiqX/D8oNSc8aWO3Nw96vbCZXO
 WmIbMUvE7i2UWwT1s3QdYbYF3D1oKuL1RyIq4xW5dEbfS3QRlQtQL7eVKVLfbM1lZn516nSs+O6
 QazGRWVCyPTGUv6MuT5A0dwbFw2a3kLkCX7tCrekE+BlNLXNxMTfj0vhadSWgKyOtcbeSeLx5eK
 kFcjyFio5ed07XMgsSAMa3p+UlVT2wABUVaS+qxe475czbs6VbbLX8J2AgFy8Ok9XJnBQgEfOjk
 6wJY/IEUAwUW98/BQ7sWnmGHuS2rNWvbPUx0U=
X-Received: by 2002:a05:620a:4542:b0:90c:fc17:95f6 with SMTP id
 af79cd13be357-911cef0c256mr1702764285a.49.1779052372709; 
 Sun, 17 May 2026 14:12:52 -0700 (PDT)
X-Received: by 2002:a05:620a:4542:b0:90c:fc17:95f6 with SMTP id
 af79cd13be357-911cef0c256mr1702762385a.49.1779052372288; 
 Sun, 17 May 2026 14:12:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164bc20fsm2874458e87.43.2026.05.17.14.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 14:12:49 -0700 (PDT)
Date: Mon, 18 May 2026 00:12:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jianping Li <jianping.li@oss.qualcomm.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com
Subject: Re: [PATCH v5 5/5] misc: fastrpc: Allow fastrpc_buf_free() to accept
 NULL
Message-ID: <s54mqp3n6gbny4su5qysslmduxxiwkv5qsezh7jeha5oqphvdr@fba6tocb23wq>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
 <20260515124217.20723-6-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515124217.20723-6-jianping.li@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDIyOSBTYWx0ZWRfX5r7AV+1SQQDY
 Nm/bVCTIP1oqWQav0xt8JugdTYIdocOJnrevwO8GaHqWT3HjoOeT5aHvJTaFejy+kCHSgJOc4hG
 0lZjRQOLts0h26EKeJz4hNUNX2w2K6f4D2YOy7E1vs95IgJ5FI6HzFuLVhbsF3l+6BKhXujsFF7
 oibBJY+IB+7GuNAlPvJ4rUMPDmHjU2msBIIbpV2blgwPTfEvf1VkKJRmZ+Z/IZ/VTpiC0nOwBLX
 CdJ8qjr3eaOWoHex6brfmcBhk0+8pLpGALnPhuMK7/Ls4F3hFhfwN7FdmhDa14NTsK/2eQ7o3IT
 uNpgMt9sCSLugwot0OkvvJgSu0DXWN2xtYXh8u5PDJZlqoMjzuE16CVVvyzvkUJef+2cv5WmeGE
 Vq+q4QS8dpc8oGQHJOY82Rn43C4VVj43i2GwEDJEzVvalkT7Yb7w5IQXsU0/AeB2Qx1RjtAet6D
 aNWaqv7IgpGGMl5urRg==
X-Authority-Analysis: v=2.4 cv=a8oAM0SF c=1 sm=1 tr=0 ts=6a0a2f55 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=76wLrWbPWh7v4vPYDgoA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: oLL0JwFrU1eqBQ1muvIfc6DTyF3aE8Q3
X-Proofpoint-GUID: oLL0JwFrU1eqBQ1muvIfc6DTyF3aE8Q3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_05,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170229
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

On Fri, May 15, 2026 at 08:42:17PM +0800, Jianping Li wrote:
> From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> 
> Make fastrpc_buf_free() a no-op when passed a NULL pointer, allowing
> callers to avoid open-coded NULL checks.
> 
> Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
