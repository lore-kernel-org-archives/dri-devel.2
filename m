Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD5FF364BA
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B364F10E08D;
	Thu,  9 Apr 2026 21:28:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PuTXtdBd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NWa31Zm2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D06E10E087
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 21:28:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639JD3QW2867026
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 21:28:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X+Qz551vlVnzXmqr6x8LCPyptEWu8XeslSycSwIXDS0=; b=PuTXtdBdrRm4p5Io
 AzyyiocfRYzsHY684LKJzl9effClSgcO0/zSLt2WOK8ZUOQmOkaaIRGkSu8XrANU
 ew0sEEeUPmsheH6XUi8tA/G97/b8N5YG6HQrNmfytdllqTZaq9zcxj1Cfj1g4Teg
 Kbo2foua2kYDxCXyzJcNcvpgNenDSMCy1ViiesHBkeh1/xiwdXYHeGBVBm+q+Pwr
 60LExhvQ1dUabwXa7PCU4zOWfkoOsvNYvLBxYwUzozVoPOdYjPCUYyEIAFwElIMD
 BJjsztjs5Tc82EiNgQE2tnxc9t6zrMR5G35jmUJhY1cB0FCHKSM1quavTrLjIpXA
 DeFyJw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decayhuxm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:28:01 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c16233ee11so1776095eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775770081; x=1776374881;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X+Qz551vlVnzXmqr6x8LCPyptEWu8XeslSycSwIXDS0=;
 b=NWa31Zm2Gd5JxAj4/uFApNqBhPQVerj53v0zBE7leWKGOxLC306u5terVJJl6Xjo9s
 83+VTz0N1IXITX6EmjzakMNMN6RteyOsRU8KDSwxbPYja3SfluXYKgKoEprEhki4p1xI
 sjVnNIHH6Q796sM5mw5KN2zsZcctuM/w+e9+T0R+0S48hCjvzNqt9pxLnfkw+cGVj8HB
 UEhUj2hY2POsE58UJmB/IMfHu9FWwlpVZD/k8CSDy9sUHb2sEPydsfPoeeHJa2YKz2/S
 LLO4vofrIK41MC98Bndwshx02/p2nyJzDA24Inywjk1axbn5SQq49PIv3esUPJgddJ5W
 G6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775770081; x=1776374881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X+Qz551vlVnzXmqr6x8LCPyptEWu8XeslSycSwIXDS0=;
 b=Ef26j9gtX3IAmd/pdRpAgleFELHYy/HlliEeqFLaPjlA0rsrWAoBHWO/xaUSszkmSK
 84+k70IBTr1MplEEud5hGxZ5rdAhfBAg35P36jJt9c78U4H15MYTTAJ/Xf8WLXIyTdhO
 zhwbPXRzpBpN6V5SnR1188YBiANFYlOfe0aIyiy20M3i4GfpTTgIuAosPmhO4Uoa/jFg
 KoRP5KPM8RCrvSXIAmNtGkbDLod6jE5AJUXVTBLtTCod54/9x6jHP3zOyDJY5NyVeLcR
 DMG4iYey4ZRx2Bd0FpRZEEvn6+PNpWBrSPdEp2fOnUUh9RPpGUxoPow6WTYheyG++cFw
 3BqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMC1C68OFy33TqjQlBcdYQkOYKCRxg9T+277UjyjvV3HvDQ7EoVnIoJTsiHt3bUTG5+mUeGjrMykc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1nqlJb6B08uAbkK2FZNFwC/n9Uz0yXEE+YU3ZxOOASt/3dWKp
 RACD0q5amOuQaOl5YN2xpI+GoZRsbnD4s3vOXEbL6jMNQS5uCB+3K9k9ENA9F52nkSI/HL7vMwp
 nohw+XQNf4BPhF2q/V2upGKe96eaDUR2N2F+TC0ck2VmNW1ARRxOPbJXCLsmhF/GFkKRIaKQ=
X-Gm-Gg: AeBDieuffoIuCTTNLvOroE0gkV3VWqn0Pf9nsuhvWi74otElrHxFjkDs6neVNeaLgyA
 Dp0XtU0n1qdM/9wgh41O5NqOVerHvaTCZUfW9yM9G2r9jSVViTJGz9kHwJkDaUGPURlGC92E19b
 6OQoQUFnFWq1OVmi5XpSA8q7sRVGgJNTijZvrrlqeVn9AUSEr386z7SFClsJzEkWgJFHouqt+Ok
 GIFjv8bJkaNx8Evr+lLUkRYn+gSzU4oJ+7LvS6cF/XvAvjmiULBz4GWG99ziGZnhYKAaoVRM/Yg
 7BK38Ku1Jxff9LFKyZ0F/UEyb54OWvdTNo/KhTpTCclkCf52vOuLBlQiS/nP6ogrcaAXEbPquIE
 POvTwGGH1YGap8u1U2yTrt5qinXEjSOMhTnr2HQk/5fXv5A+J9C9dX4cR7JS/Vy841gSzIow1AI
 M=
X-Received: by 2002:a05:693c:3005:b0:2c1:7ea5:ec29 with SMTP id
 5a478bee46e88-2d586eaa366mr441796eec.4.1775770080857; 
 Thu, 09 Apr 2026 14:28:00 -0700 (PDT)
X-Received: by 2002:a05:693c:3005:b0:2c1:7ea5:ec29 with SMTP id
 5a478bee46e88-2d586eaa366mr441778eec.4.1775770080326; 
 Thu, 09 Apr 2026 14:28:00 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d55faa571csm1665997eec.10.2026.04.09.14.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 14:27:59 -0700 (PDT)
Message-ID: <031702af-5976-438a-841a-48e95f41eb03@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 15:27:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] bus: mhi: Capture DDR training data using command
 mode
To: Kishore Batta <kishore.batta@oss.qualcomm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
 <20260319-sahara_protocol_new_v2-v4-7-47ad79308762@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-7-47ad79308762@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=69d819e1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=U35_I10QZVw-_bRh5h4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE5OCBTYWx0ZWRfX+wiPghesqAkT
 sGXHTVlLNp3k6oB6X8n0STCoZkraml0fpU8nOJ+ju0vE6pixrEqde6F+6XSJcQ5gT8qspK9vkS/
 zF0qBiZvH6bytqKuLKZMyJ19F3P7XrMtFYT4IL3REB8IrxsEv8zDI7ivJdqBmfOMDVNGkVgaTtU
 Guwi8qKq6O/RCJooZAZNeG06E8CYrHe1XnZOx1jjNBDK+dv19m8INPMWQNg54I8MKUC7YRNUTy0
 SWqtXUWVGVia7zp/Bws0pvABzsnOGu3J1mBhrKoFrnAh1i2SHMI664LiJVroiHUFx9aWu0nmQtU
 C/hFMat9wcXm9avCidfvV5nKAfGEl4NopeDu/xqFgOqrDOc2MJx09vBaRGpY0wq22pz4TCu3Bcl
 MUggJ23V1w5f8NsiDpF01yx+VQkl60SoJUobOnPQYQbPMnz9PmWpC101Lsb77q11BPm8IBYSeJq
 Wjv6hk34LIpPEU0+3Ww==
X-Proofpoint-GUID: CQjhELyJIkVt9uJJlEI_yv8NnSDZyHOL
X-Proofpoint-ORIG-GUID: CQjhELyJIkVt9uJJlEI_yv8NnSDZyHOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090198
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

On 3/19/2026 12:31 AM, Kishore Batta wrote:
> During early boot, devices may perform DDR training and produce training
> data that can be reused on subsequent boots to reduce initialization
> time. The sahara protocol provides a command mode flow to transfer this

Sahara

> training data to the host, but the driver currently does not handle
> command mode and drops the training payload.
> 
> Add Sahara command mode support to retrieve DDR training data from the
> device. When the device enters command mode and sends CMD_READY, query
> the support command list and request DDR training data using EXECUTE and
> EXECUTE_DATA. Allocate receive buffers based on the reported response
> size and copy the raw payload directly from the MHI DL completion
> callback.
> 
> Store the captured training data in controller-scoped memory using devres,
> so it remains available after sahara channel teardown. Also distinguish

Sahara

> raw payload completion from control packets in the DL callback, avoiding
> misinterpretation of training data as protocol messages, and requeue
> the RX buffer after switching back to IMAGE_TX_PENDING to allow the
> boot flow to continue.
> 
> Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
> ---
>   drivers/bus/mhi/sahara/sahara.c | 328 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 320 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
> index 0a0f578aaa47ab2c4ca0765666b392fb9936ddd5..c88f1220199ac4373d3552167870c19a0d5f23b9 100644
> --- a/drivers/bus/mhi/sahara/sahara.c
> +++ b/drivers/bus/mhi/sahara/sahara.c
> @@ -5,11 +5,14 @@
>    */
>   
>   #include <linux/devcoredump.h>
> +#include <linux/device.h>
> +#include <linux/device/devres.h>
>   #include <linux/firmware.h>
>   #include <linux/limits.h>
>   #include <linux/mhi.h>
>   #include <linux/minmax.h>
>   #include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
>   #include <linux/overflow.h>
>   #include <linux/sahara.h>
>   #include <linux/types.h>
> @@ -60,8 +63,16 @@
>   #define SAHARA_RESET_LENGTH		0x8
>   #define SAHARA_MEM_DEBUG64_LENGTH	0x18
>   #define SAHARA_MEM_READ64_LENGTH	0x18
> -
> +#define SAHARA_COMMAND_READY_LENGTH	0x8
> +#define SAHARA_COMMAND_EXEC_RESP_LENGTH	0x10
> +#define SAHARA_COMMAND_EXECUTE_LENGTH	0xc
> +#define SAHARA_COMMAND_EXEC_DATA_LENGTH	0xc
> +#define SAHARA_SWITCH_MODE_LENGTH	0xc
> +
> +#define SAHARA_EXEC_CMD_GET_COMMAND_ID_LIST	0x8
> +#define SAHARA_EXEC_CMD_GET_TRAINING_DATA	0x9
>   #define SAHARA_DDR_TRAINING_IMG_ID	34

Why is the indentation of this line messed up?

> +#define SAHARA_NUM_CMD_BUF		SAHARA_NUM_TX_BUF
>   
>   struct sahara_packet {
>   	__le32 cmd;
> @@ -97,6 +108,19 @@ struct sahara_packet {
>   			__le64 memory_address;
>   			__le64 memory_length;
>   		} memory_read64;
> +		struct {
> +			__le32 client_command;
> +		} command_execute;
> +		struct {
> +			__le32 client_command;
> +			__le32 response_length;
> +		} command_execute_resp;
> +		struct {
> +			__le32 client_command;
> +		} command_exec_data;
> +		struct {
> +			__le32 mode;
> +		} mode_switch;
>   	};
>   };
>   
> @@ -163,6 +187,7 @@ struct sahara_context {
>   	struct work_struct		fw_work;
>   	struct work_struct		dump_work;
>   	struct work_struct		read_data_work;
> +	struct work_struct		cmd_work;
>   	struct mhi_device		*mhi_dev;
>   	const char * const		*image_table;
>   	u32				table_size;
> @@ -183,6 +208,24 @@ struct sahara_context {
>   	bool				is_mem_dump_mode;
>   	bool				non_streaming;
>   	const char			*fw_folder;
> +	bool				is_cmd_mode;
> +	bool				receiving_trng_data;

You already spell out "receiving", spell out "training".  I don't recall 
seeing "trng" before so it seems like a really uncommon shortform.

> +	size_t				trng_size;
> +	size_t				trng_rcvd;
> +	u32				trng_nbuf;
> +	char				*cmd_buff[SAHARA_NUM_CMD_BUF];
> +};
