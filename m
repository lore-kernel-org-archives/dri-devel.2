Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01565F44840
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 11:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E95910E938;
	Fri, 10 Apr 2026 11:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="GeBFTT3N";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BE710E939
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 11:22:14 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63AADVLm1925453; Fri, 10 Apr 2026 11:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OXCDEuWxbaerERvBelLzYgqdWH9OXFRHW+vN3cYatsk=; b=GeBFTT3NU1FSM6Hj
 2H/Q7pmlAT4qe7QOhaKVrZ75sFot43vQAH/ZP7Y33Vu+BaMZmQfkzDAawcDzGOeD
 KOA8vlG50i+byMO8TqcO0eeTh97OqkzFO4SIhfX4xyBxCkoqXxunKyJRhPFNSgcM
 VFXvlJvAtM1Y76kpZ2mGh8ChBdQ5A4KiL/x4mIMmBjVT/P+qvtGIJRuSlxLSObAm
 MHmBZvI1qHXlRK6EOYMDiw3Q/4E70nZqOLx3reTJd6hAx3DoHXUkKrq7qakIkCNK
 CLiSB5yef4Rch6kFbaLlTn/3YeWAOdDDTAi34BJ0fXSreoIR7Uxa+CJFtaM6pjDg
 b11yxg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudjs5ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 11:22:09 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com
 [10.45.79.139])
 by NASANPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTPS id 63ABM9nl017097
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Apr 2026 11:22:09 GMT
Received: from [10.216.26.180] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 04:22:05 -0700
Message-ID: <fb37aa8d-bc61-48fe-9c82-828e7fd642f9@quicinc.com>
Date: Fri, 10 Apr 2026 16:52:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] i2c: qcom-geni: Avoid extra TX DMA TRE for single read
 message in GPI mode
To: Aniket Randive <aniket.randive@oss.qualcomm.com>,
 <mukesh.savaliya@oss.qualcomm.com>, <viken.dadhaniya@oss.qualcomm.com>,
 <andi.shyti@kernel.org>, <sumit.semwal@linaro.org>,
 <christian.koenig@amd.com>
CC: <linux-i2c@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
 <naresh.maramaina@oss.qualcomm.com>
References: <20260410101949.2315058-1-aniket.randive@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
In-Reply-To: <20260410101949.2315058-1-aniket.randive@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=X+hi7mTe c=1 sm=1 tr=0 ts=69d8dd61 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2ZZFV4PajdD4Tf-m3e0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gRq6W0F6IGuJAnJhHlCPTtFpLZTjLa7V
X-Proofpoint-ORIG-GUID: gRq6W0F6IGuJAnJhHlCPTtFpLZTjLa7V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDEwNiBTYWx0ZWRfXwOqFuikj+wsJ
 Nns3Qy0glre0sxugk1cvT+ttj1yIvRP3n8VhRfH4xTL5Sbk80NaB/UX4AAZbjlantZO+ozfjSB/
 MsfzSZ+sWAaSfJmhgc36qRY7u0V4PJgEjGNTQTaNvJIBXrUED/YvY6THa83wQH+XdFDm5p2IDcb
 hRfTXzv6ePnBnA7KzYQ3xS/baN+CeUjaXJeiwyHXMxXmI7c/gsyF+QTxANvKv3xtkU95qE9pa3Q
 GBh2WNEao+QEhmAS+CPijjNGjTo7L+aTonS2oz1mxUMQl3QYyWfey0SSmBUy6+CJf3FWjs/rXGN
 JLmS9ttJw15Qzd3C0bn+oDOxL/R+6w3L7kdNBPJlBMomd6w5bABAT31XI5bel2waNNtyzSLoil8
 ZouoRu7+3VexVNpIRfYX4axBgB6CJ6i8ipbT74oN5ApCEyLzH0ojaE3fwY7mTf5fyp4szp2lFuk
 rtMM+1Odb6UoEYuo7zA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100106
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



On 4/10/2026 3:49 PM, Aniket Randive wrote:
> In GPI mode, the I2C GENI driver programs an extra TX DMA transfer
> descriptor (TRE) on the TX channel when handling a single read message.
> This results in an unintended write phase being issued on the I2C bus,
> even though a read transaction does not require any TX data.
> 
> For a single-byte read, the correct hardware sequence consists of the
> CONFIG and GO commands followed by a single RX DMA TRE. Programming an
> additional TX DMA TRE is redundant, causes unnecessary DMA buffer
> mapping on the TX channel, and may lead to incorrect bus behavior.
> 
> Update the transfer logic to avoid programming a TX DMA TRE for single
> read messages in GPI mode.
> 
> Co-developed-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
> Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---
> 
> Changes in v4:
>    - Added some more description in comment and changed the label name.
> Changes in v3:
>    - Added comment in the driver for better readability and changed the
>      position of 'skip_dma' label to allow dma engine configuration.
> Changes in v2:
>    - Updated the commit message.
> 
>   drivers/i2c/busses/i2c-qcom-geni.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index a4acb78fafb6..a482a4c60744 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -625,8 +625,8 @@ static int geni_i2c_gpi(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[],

[...]

