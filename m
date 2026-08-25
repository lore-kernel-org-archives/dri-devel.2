Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06259C61CE3
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786BA10E19B;
	Tue, 25 Aug 2026 06:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IiSyRJuT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CNjL6uCt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9278210E19B
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:48:02 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P2R3rb405004
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Gyh9XcgHUZTAH+0naOsJaq5PNQKLw6A9D5m3uUaqHmo=; b=IiSyRJuTk7oCrm/1
 DZn3eKlQs5kB0XQVMPKFMCj16/YQ8lPXAyaop6Xqtdht4kLBo42CBGPjprsZCO3S
 4RuHfvSDDA8sDTNCoqAppM+6zLDbl1JAK93p6hnVw9sdf8pr4pwRFpCbothlsv1T
 gt/WHGDZfjAOLt7ad0rx60bZsCFZAm0xaP/KphAiEGaQL0tU+Cre6Wek/yxmpGSP
 F/9fCLtz75mTsZcT2N1MW/CwTztgpx09Osl4HenZZymCfpoeoBV7u+iCkJwk5umR
 rzK2hLcPZ2kwGYfRu98caA9e+fFcREe9fpsvWDpaN1GFSPoK2xO67M62fXvlS3Or
 kESoXQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8y5jhaab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:48:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d63bad3d09so53340045ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 23:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787640480; x=1788245280;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gyh9XcgHUZTAH+0naOsJaq5PNQKLw6A9D5m3uUaqHmo=;
 b=CNjL6uCtoBQAjJGj6+wrHV0K0UTuDxFXJ5XIQ+Euhka6qw/80I93Hj5nowK7f8oBJU
 O6ALBoxN/mqWLQcKYhtdl/dxMgRbNz2mdd/GbYaaaNUnHY+C2LOscT0bRgtJRrG5it7j
 UVGZVQlvu+UztxWlWT2zJz98MH3tPvLLd/Ra+ljXQXOr96tqCLacu/4U3AQEnOh2zdJ9
 VY10vPGUHj6BWYgiOCQVSP+cJyd8MkFlSYMcEWa4Py/4SJy3RREkPQuzreBDsHF9Y587
 wYGfNZQFo9GKiSirqAvikJlhfduSgbuELa5oVuFabZNIh4kBQ2d5z2BA5XviBRnOvHvP
 l87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787640480; x=1788245280;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gyh9XcgHUZTAH+0naOsJaq5PNQKLw6A9D5m3uUaqHmo=;
 b=NbP+3RXJSdyE4zA5wzorzC6U28dLWWvAclypdsy85yA3NcNSzmXBn7o1/QgU2sSv9/
 EP3TZ0AzftDvHHAOZQxMx1TNVHIlWkZK4Ysb/XBQF2gmwx7iW7ic46lvtRdwVqOMMM8x
 FdxSo0+YHvm2XlkddFut20oNR5oHxCYpFUS9bGbH8BEt1TZC9gPoiyIUoSI/gO4hLxtU
 ATEOX+1H5BZ958PWBHh5jhhOkUsZsRAErxnWMUnI0rENc2t4rWxdnizKPXt1mbYRt1p1
 4Bvl4AZ376L/EUM26ZkvlSvEaiTLsbMX4IstXgoPN2kSASiajNgDe8zPfzitQ6+KiovG
 mv5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RooZieUSlq8QXPBk70MQZUQ+w20nKNATjmuQS1r4neZRr3r5lLHWNrSkz8dQWSWG1PhsrYs0DIsC9Q=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mq+XW3nY6yeb8tw/zh+WMIYR0bAHoqkttKs5xKro4gKLmfSkez
 dji7L4DA8KtpJiUHJHzR51Rmx5PlIpUOEDM8JEDe2QHSh7x7stpoQf52ZynjbJ2HmNHVAvn3Iy1
 +cqhBaSuu6h4T7VxNY5L5QO940gRQN2SeiyiQJXlVEJJugGS+2E7llQlEU+zlq5Bz5Rlf0y8=
X-Gm-Gg: AR+sD12xaUa2AcO1FudG8ClpxNKum99ofibpmv5szC2EmpRd08esG00fZKh6XEsj99g
 21Kt4PamqMIVnb/QatLmrACpHwm8MQdUV5pb4HBEVKgi3E4ajNGaB9BtP17R1DhHHIan5SFwoiT
 /r9jtKVBjGYq0D/wMe+1rbuPXFYEeSIBNFgyrLKuItzshzOEpU0gBpcmSjrO4dCylF995IHMtf2
 YeXeyq9BEvsRxVXlBkXUpekdnyMYZ1pAt/ITRLSv04KaXiwWXhm6+2HjeAUWxY8E2iE/Hwjqa3u
 C0xkfC0vurJR2bPy2zjO3AAljp2fmy+oVDjRRgxx7UtqVYnZshMpb6y3uaciuI67dvgG7m7OeBG
 T4ENweOUN+g/aT/IKbpSVIOxexbUGXw==
X-Received: by 2002:a17:903:3904:b0:2c7:ebfb:618f with SMTP id
 d9443c01a7336-2d670d299bdmr452010185ad.14.1787640480364; 
 Mon, 24 Aug 2026 23:48:00 -0700 (PDT)
X-Received: by 2002:a17:903:3904:b0:2c7:ebfb:618f with SMTP id
 d9443c01a7336-2d670d299bdmr452009385ad.14.1787640479831; 
 Mon, 24 Aug 2026 23:47:59 -0700 (PDT)
Received: from [10.219.56.151] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d676761bdesm25061285ad.1.2026.08.24.23.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 23:47:59 -0700 (PDT)
Message-ID: <dcf8d925-cf9e-47d8-ad79-0b5e641529ee@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 12:17:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastrpc: Reduce log level for DSP info and reserved
 memory messages
To: Jianping Li <jianping.li@oss.qualcomm.com>, srini@kernel.org,
 amahesh@qti.qualcomm.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260514062825.50172-1-jianping.li@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260514062825.50172-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O5QJeh9W c=1 sm=1 tr=0 ts=6a8d3aa1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=7I6ySQAFBpFkhykqCKYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA1NiBTYWx0ZWRfX3nmSoT+z2dCc
 y/OGlgbdH1Mt9MNhy8hQpsYHvTmV9AqyiZVpzDigJkOmMI4WKzV+JBj+DcldLKv6U6dYn+FWtWS
 VdgssLmYxBXiKT43yMC671Yq1iKhvABDPZlRsbBBwJSzrX9A1GOql+wGrihf7I/IL8a893KTXgt
 FzY8yTA6USVHFfkw9mZE9e3R85Zpe472lo2xA5c5zR/eAh1y9DZukc4cfX7TOyVd4n8IqZF0m+4
 GLQ/4oPDL5W+/EPVZ0M0gB9tX6TbBAn7IM8XPiVbt7gUUcB/06q5wsNs8V1Bp/+tgCT1HMNX8xr
 IGaLu/G+5ozpi7zRZNsQON82rElYAQ081MlfQ4g4FcxGDhG3JCBjTW5jld/1KVDa63CnSgMNQSy
 mMIIZjyzod8wL12JmkxSh/JYi3NBOtfbUNbOMvKYuZ/YIPFUx7W/Jk+AcnFVz27f+IZpoJwNz3X
 h1BCurREOxNFZoJbXZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA1NiBTYWx0ZWRfX+Lm/bJgKbDOW
 oPKbN8r9C06Nb8s7x50FmgR1oDCI4AeYmk0LKY2cZfrb24Kuplr/V7IEaYrM308EySeWfBYbH9D
 w6pSBjNaSNmx5nJrp37NF4vGzXNlZCI=
X-Proofpoint-GUID: I8rsWl4QqXpM3w773_ZP48P0pPOaFa9v
X-Proofpoint-ORIG-GUID: I8rsWl4QqXpM3w773_ZP48P0pPOaFa9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250056
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

On 14-05-2026 11:58, Jianping Li wrote:
> On some platforms (e.g. QCS615 Talos), fastrpc may temporarily fail
> to retrieve DSP attributes during boot, resulting in repeated
> "Error: dsp information is incorrect" messages printed on the
> console.
> 
> These messages are observed continuously during boot when metadata
> flashing is enabled as part of RC releases, causing unnecessary
> log noise.
> 
> Similarly, the absence of reserved DMA memory is a valid
> configuration and does not represent an error condition.
> 
> Since these scenarios are expected and do not indicate a failure,
> downgrade the log level from dev_err/dev_info to dev_dbg to avoid
> flooding the console.
> 
> No functional change intended.
misc: fastrpc: >
> Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a..05ec14c07fd0 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1802,7 +1802,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>  		kfree(dsp_attributes);
>  		return -EOPNOTSUPP;
>  	} else if (err) {
> -		dev_err(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
> +		dev_dbg(&cctx->rpdev->dev, "Error: dsp information is incorrect err: %d\n", err);
>  		kfree(dsp_attributes);
>  		return err;
>  	}
> @@ -2361,7 +2361,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	}
>  
>  	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
> -		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
> +		dev_dbg(rdev, "no reserved DMA memory for FASTRPC\n");
>  
>  	vmcount = of_property_read_variable_u32_array(rdev->of_node,
>  				"qcom,vmids", &vmids[0], 0, FASTRPC_MAX_VMIDS);
Can you also move this log[1] to debug level/rate-limit? This can cause
dmesg flooding in case all the session are already getting used by
processes. Some discussion around the same happened here[2].

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/misc/fastrpc.c#n1786
[2] https://github.com/qualcomm/fastrpc/issues/383

