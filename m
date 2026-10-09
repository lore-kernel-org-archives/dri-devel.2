Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D706ECA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:11:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F6B410FE8C;
	Fri,  9 Oct 2026 06:11:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9/ET0QY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OKqHLlLr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FE010FE8C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:11:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6993HRZt1089587
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 06:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3hOn6raAcGNFw6Nr4o3rlG6f+gywDsQ3FA3PX1oZuQ4=; b=O9/ET0QYXa0ojnp6
 uErL892z606ka08h489t1yy2sqohTJMXEj6zkhVtM9OU8+Ds78XV7gXZ59fZDfsS
 5PmHDU/3ugLrCbXBTncK1ZinCNqHGYLWc/GJgk1HjExatySW5UpbIxgQI0afaWNN
 /e+i+tA0d+QOsOjPIwePoGllMg9wsQlrJiD1Z3wwqtDYbatEkrazcHVOSK9wU0kq
 shhTsCeDP2Px+IF5rUvQlgvkiOfgK98JaCeJxouhZEjf6QWtq4H+JYvl9YYXdZZi
 SfSZdUO9x+ejbxkaKzG1lK7Esa7P/VVYLKalLbUxuJTwp9e7tA6c03o1o3EjLbkl
 zmqU4A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvagf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 06:11:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc73895c7d5so7055318a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 23:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791526298; x=1792131098;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3hOn6raAcGNFw6Nr4o3rlG6f+gywDsQ3FA3PX1oZuQ4=;
 b=OKqHLlLrYG5iQ8S6V4ilUsF02aObLeJgDIkMSxI+OImQ5QJ2309FRxkaT6yRifpTGl
 n48UEan7JHHJIyL9ApqgFXbmK6ptTsh2qGoDVwp7UOf1DZYnYDBZ1Dol2ytf/daWnPAf
 0qFfYCLTaEgtfLeBs2yR/B/QL/Hm4Z92NQUPPo32XidKdtdYUtuWChcQ4+XHimeR+uWQ
 cgIvKJDi/urNFq4czcnzohFcYh8cVklKwov93FSdrUTskp5a45ehMR4pMU5OovZ6a3vw
 AuITg4UoGMvtyigDq044tmZEdIXeg4a/kQwsy/9ysjPdLB5EdsTy9cWiblhDkZUfypj7
 bYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791526298; x=1792131098;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3hOn6raAcGNFw6Nr4o3rlG6f+gywDsQ3FA3PX1oZuQ4=;
 b=zvCAfwPXv4MHc6bfoxux947cZwNiBENrLAotntZG/uSwuj/K9qxix2TmNNms7MFYM7
 63ihn7N4tuXrp4jhbKBKyf9DuRgxMFYoAg6uwImSVQWM7MX029QAOFT61iJaWQOXK23E
 2HpeSWCTk5UUHXZXJgefvRt1pdsvuc+nzVzP94AVIZLCjMi34tpscQ5ut8tIi6DNiepX
 drsXO6ynBnCONMKM11VbkKIFp1yBfgTmCn/3s8J6DigOl++qIdhEJHwdCTNHFK3k1IFm
 72UdsJhnf9PV5dkxMCpOcKkZ5evC3P0n+EGKDP8WnvoRTek12CNpwwPyvbHmTM4M4zk2
 a9mw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgnEIUMSbb7wBxix/sEkx7B9x1uWZcI4p7PH8g1gVBi9Kb7PwAGbEo9EMeRV6SGoVCd9UG5eo3JNU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++njVYUNsTHRKEJJZeAbI7Z5PfpninVwuTUimfSPhbTTsCNNbY0z
 2jeEr8t+pqwKwGipnEpLxHB59buf3Rzw04mxhXQQ3V3F99coh5F5blsX+HCXzNax4NG/n8kq8dj
 w+cvg+nwIVY0Gr1gApJz/eMc13B3Y299KwueO0PocNaw0jk9OiMOGC7r2b9WscrZ90a5w6AQ=
X-Gm-Gg: AYBFou1U2FKL++bciBH4ZLt9w87G7aRXONYS3KPY/vZ8qe6PclqfYZAyHceiR+H4QIP
 BkYvbVkPQcHSOBWhpn5dZzpJhI8KDpR3AUqMToICWIlEDeQFXHhWLRRR2y/wFUEmngD6HDS8gmj
 DjvU6fDyfJoZzS6uuqXZQIqsAPxEOC6yDtEhAXFbrSXiaDgbfk4YL4lcBED9Y7K3BYre4BbGKu/
 /wTp7Tky4vmsYuIMsN/t3W5EGkhPOtNrIo7MDDvmtQX7jPSQcrT2uVV49L0r1tniJaE9hv5TWLm
 ZuX1SqFqg6tpvcHybxpmU6iEUeMq6TrVw/MbWsGRvefNC8d+PDkPJOs/PEg0pddyzJEnNEy8Ej8
 yMqkBIEfPCGxK56bZE4iRaETUj6TC
X-Received: by 2002:a05:6a20:748c:b0:3dd:a197:ede8 with SMTP id
 adf61e73a8af0-3e16bef1d07mr701369637.55.1791526298483; 
 Thu, 08 Oct 2026 23:11:38 -0700 (PDT)
X-Received: by 2002:a05:6a20:748c:b0:3dd:a197:ede8 with SMTP id
 adf61e73a8af0-3e16bef1d07mr701360637.55.1791526298064; 
 Thu, 08 Oct 2026 23:11:38 -0700 (PDT)
Received: from [10.219.57.162] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c3106e07sm467718b3a.11.2026.10.08.23.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 23:11:37 -0700 (PDT)
Message-ID: <041b1648-1320-4394-8282-3d1cb1203d16@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 11:41:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] misc: fastrpc: move ADSP duplicate session
 creation to the driver
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>, devicetree@vger.kernel.org
References: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
 <20260923-dup-sessions-v5-2-e953133a1827@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20260923-dup-sessions-v5-2-e953133a1827@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yxNkAg94z6soymG6Zxboua_m6O2vVL4V
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8859b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=6scLBf4XpmJJRpZfmIIA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX3VaGXBGLQ1nh
 OWUXau+tsk0LCluGIGsJ9XbcaO7y5/eu0wAlhBYNRhpMupeslrexOG+hb0PPzwXoORG6DEbPLxf
 BGPHMEcW2SpP6lFJn7NY+Gj4RTO6VTqgs0STpr9zRrCr1xdL6GfBtnMHqUmw+yYzHGPvo//v9t+
 pM/EiJkT51G2//jcAFqN4l40m3+weFiv0DnsRXIzWqvzaC4fhPv63Uq6a+u40vR9ipRkzjyjjr3
 rJg0gI2nelsYqSMVuMuKjql4NKMfwGAYsqkenoPzuXX/RXALUdaOXp1Djs5A5XYO7B0xiVDkQhH
 hBfJ5ekTcUPGEuJjO/kOxrgf9XzmEtBwldy+jnAFYzBFzC1AOK/3Cl+sExDcTV6yUrypl5cHpzR
 sp+CYSCaatiAV0WJ4OsuVp4CQOEEdZ8H57jDElD8gbVU4FUVrfgQI/iCtg8rqrChXHRU3MQ7Stn
 cTggJ5wd2YirRWPmkJg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX3zktf0qPs8qF
 MPKmsB0nPIULkm2u24Mjk6L28F9PcBAvaD/JiwAzqlsCVATo/sm1GY3NI/cp3m8I5r0+1PTvY+9
 EmRCtYoRdwWHbbKfQrd9f+syD38cNdU=
X-Proofpoint-GUID: yxNkAg94z6soymG6Zxboua_m6O2vVL4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090024
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

On 23-09-2026 14:09, Vinayak Katoch wrote:
> For ADSP, only a limited number of FastRPC context banks (CBs) are
> available. Each CB supports a single session, which means only a few
> processes can run on ADSP simultaneously. If all sessions are consumed
> by fastrpc daemons, no session remains available when a user application
> starts, causing the application to fail.
> 
> To work around this, qcom,nsessions = <5> was set in DT to duplicate
> sessions inline during fastrpc_cb_init(). This policy does not belong
> in DT and should be handled at the driver level instead.
> 
> Remove the qcom,nsessions DT property read and the per-CB duplication
> logic from fastrpc_cb_init(). After all context banks have been
> initialised in fastrpc_rpmsg_probe(), append FASTRPC_DUP_SESSIONS (4)
> copies of the last session for the ADSP domain.
> 
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f20d3e5ecc81..b29c1fd00de2 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -34,6 +34,7 @@
>  #define CDSP_DOMAIN_ID (3)
>  #define GDSP_DOMAIN_ID (4)
>  #define FASTRPC_MAX_SESSIONS	14
> +#define FASTRPC_DUP_SESSIONS	4
add some comment here>  #define FASTRPC_MAX_VMIDS	16
>  #define FASTRPC_ALIGN		128
>  #define FASTRPC_MAX_FDLIST	16
> @@ -2338,7 +2339,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
>  	struct fastrpc_channel_ctx *cctx;
>  	struct fastrpc_session_ctx *sess;
>  	struct device *dev = &pdev->dev;
> -	int i, sessions = 0;
>  	unsigned long flags;
>  	u32 dma_bits;
>  	u32 sid = 0;
> @@ -2348,7 +2348,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
>  	if (!cctx)
>  		return -EINVAL;
>  
> -	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
>  	if (of_property_read_u32(dev->of_node, "reg", &sid))
>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
>  
> @@ -2369,16 +2368,6 @@ static int fastrpc_cb_init(struct platform_device *pdev)
>  	if (cctx->domain_id == CDSP_DOMAIN_ID)
>  		dma_bits = cctx->soc_data->dma_addr_bits_cdsp;
>  
> -	if (sessions > 0) {
> -		struct fastrpc_session_ctx *dup_sess;
> -
> -		for (i = 1; i < sessions; i++) {
> -			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
> -				break;
> -			dup_sess = &cctx->session[cctx->sesscount++];
> -			memcpy(dup_sess, sess, sizeof(*dup_sess));
> -		}
> -	}
>  	spin_unlock_irqrestore(&cctx->lock, flags);
>  	rc = dma_set_mask(dev, DMA_BIT_MASK(dma_bits));
>  	if (rc) {
> @@ -2669,6 +2658,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	if (err)
>  		goto err_deregister_fdev;
>  
> +	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
> +		struct fastrpc_session_ctx *last_sess;
> +		struct fastrpc_session_ctx *dup_sess;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&data->lock, flags);
> +		last_sess = &data->session[data->sesscount - 1];
> +		for (i = 0; i < FASTRPC_DUP_SESSIONS; i++) {
> +			if (data->sesscount >= FASTRPC_MAX_SESSIONS)
> +				break;
> +			dup_sess = &data->session[data->sesscount++];
> +			memcpy(dup_sess, last_sess, sizeof(*dup_sess));
> +		}
> +		spin_unlock_irqrestore(&data->lock, flags);
> +	}
> +
>  	return 0;
>  
>  err_deregister_fdev:
> 

