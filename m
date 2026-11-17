Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B2606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X4V6PHMA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hYihB31o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6B110E9EC;
	Tue, 17 Nov 2026 15:49:59 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 094F010E9EC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:49:48 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR40K3503964
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RqqATJMJCjsooN6FrDKpV3FwcVUNXaVpOA0bEdXMNXM=; b=X4V6PHMAt/ILcHjo
 1Vq3/EoGUwQ2eP6Xx81LWw7XpFRPuFdkCTB5BUy2tFUtX6le1KWZjWOlq/lu3Skz
 vhiiK33lWjl9zF0mLUKzidsWHSfbuaXOdcvriUWTMfqABaTdHieSDeIm4NLTkGUU
 24MKhgDb3GLiIgz3UyrvJoY13bxQfzAntNMd/RoEH1PS/Ipo/fLM78C/ZQTsApbi
 HQF5X0fNjcMuYWaPpfua728/WkRHGV5fyeppeLAq07IfSWico4aUlHkyHqgA1HWA
 YIyprekKOCKDNDvWlZ4WzwcV0sudgi0axkeBPkTvV3nxrb/0K1dOUiwHaVj9lTbW
 qVAX9w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0mv11dh1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:49:47 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8aa185840bdso3766091b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 07:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794930587; x=1795535387;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RqqATJMJCjsooN6FrDKpV3FwcVUNXaVpOA0bEdXMNXM=;
 b=hYihB31o+z6+z0AnT0zKtOFP9taP0MaEGJ9gl7sT9o8Q5D4GU4fC48nh2MmMsXthfM
 G1fqCioWTXSbALG350LuRGSa3O6MynXLDDCPWhEcR+6PYDNP/LWwH1gbwDCR9KKaFdMT
 7SKiWh/t/95TSR87EqRwMS8sF+Bt2SmInjF4+4DXtx1uEzsH/bigDoo7/fmdlXD/y0BE
 Z58xaSCXZa3rpbIKulMNdGxPSPwCKh5rQ0jZskyr33b7aZs4d1oqAvTY/hvzqqY65fPj
 QxbJDI83N9SO9mxyikaqN3TQE3sV3qWn+Ia6/+et1NOtM47Z1ROO2mYFtgPULHBu2RXd
 b9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794930587; x=1795535387;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RqqATJMJCjsooN6FrDKpV3FwcVUNXaVpOA0bEdXMNXM=;
 b=sTSPGK/yyNj0YMQ7+WGY7ocd7tuja3idKZ3OP8ob6nj/Oso+qFlEIqB4g7mk5aJ2Zs
 x5WK/gyrvybwMaUNXQ520qXwhj1raBSolLHsZH3ljv2se1I/NaDAX7KFlpSit3S4TpWX
 ZYVfHEwgfy95TUyuGt1uJ2+DyGlb+5S4/FMItAuQX9KzvDRy+l2W4ebgqraF7RCjTjhH
 PEDrwoCzwvaOaXcjTc2XE7YlVVkrCOdTKxdD/WEotu1PNiXWROG/OtywsCBg1Qp5e1s/
 0ja3dmuAIZda3LM3KE1ftMrDl2x3GvtTUebqwSUee0/4WhivzmtIAvZLKL7oCjHTBU+K
 baGA==
X-Forwarded-Encrypted: i=1;
 AL+hErFUa7bGIJkjoepPhxJQHM1k5DQadrGsq+aM1NLu9J+ZF774jfiNCb6cBz1uY9Z7745A6Gz9iIaoA3Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+2LfnMfu3vR19TVyu+GP9+NoONmlwP5+bcQRigBxNfzTo4LjJA
 BjlzT5Wh3DFYWy3QY4fFImlU+vYGk5XXx+6ipQX+437eefiW0zS3xHL3/eUde/27v+LqzEiX1fD
 d3RBrEov95y4my9CJvuQto4Dub61A5WX5A/uFpOvsTtqFt8VUNxyEdWiVGdioGknarI3M7rcSEy
 +XVjA=
X-Gm-Gg: AYBFou21mRNt+llUtkdFA7SNZMzED3ERNSktb5xKiSPRocJO5EvfFCrTsqikHKCNufk
 LcmC34U39ysU5XNyWlUT4Cw4fOVpEyCr3vpfaykXXRHQ+V1VldtAa5GXWY7FoGk70/4soIlIf2X
 SacEoHAEVpDU2lE5jz9CoZnoV64GvunIoH3UPSj/+fk+RjUAXpggZg1lXsd1J3MbcdjO9IMGDG5
 3OOKd8waeMjNg2Nqci6uQXVPqY8oZR0Sst3bm0uspFa8iv2BANhoveH5ZqQooc6i/zWEZnNlLN2
 NvJM5ej65HrYst+tYly9gJ+gqofZIbVJSgeHVC39qL0By1Bx54AS/+D0K8RKTAU+hlcRZ3eVfup
 gz4LDwqYoecCoibHxKzaRSVWkx6jHowvsYZ9gsVGMlIvmZSGQEwcmvcepdRKvdJpw183DkSFusY
 TcCw==
X-Received: by 2002:a05:6a20:431b:b0:3f8:f792:2373 with SMTP id
 adf61e73a8af0-3f8f79235f0mr12126555637.48.1794930586598; 
 Tue, 17 Nov 2026 07:49:46 -0800 (PST)
X-Received: by 2002:a05:6a20:431b:b0:3f8:f792:2373 with SMTP id
 adf61e73a8af0-3f8f79235f0mr12126525637.48.1794930586048; 
 Tue, 17 Nov 2026 07:49:46 -0800 (PST)
Received: from [172.20.15.99] ([195.50.164.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bed12a90f1sm5515688b3a.19.2026.11.17.07.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 07:49:45 -0800 (PST)
Message-ID: <d38594cf-5359-4862-9e47-81e15ab8fd05@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 21:19:31 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] misc: fastrpc: drop the DSP-response reference on
 channel removal
To: Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com
References: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
 <20261117-interrupted-invoke-v4-v4-2-2320a8a7eda2@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <20261117-interrupted-invoke-v4-v4-2-2320a8a7eda2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IWu_B43vt9GAY-16f5XmnSL9ZtIcz18T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MiBTYWx0ZWRfX7XVGZuBwKtaO
 3jOloRMKGnGQSeG7OrftXtmoyBCuHnp0VbybWIjVowkGoLgVTdMqnc0y7VbZ5DKrfIYVjPY7w8z
 uEU3W0ire3XWND93jIpAraf2RnQ1r0c=
X-Proofpoint-ORIG-GUID: IWu_B43vt9GAY-16f5XmnSL9ZtIcz18T
X-Authority-Analysis: v=2.4 cv=Cuwq4X4D c=1 sm=1 tr=0 ts=6afc779b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Jk2/TV77q6/E6wQq2oQJxQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1jytM14GPKulnBB8BfYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MiBTYWx0ZWRfXwRpW4N7BPrJ4
 BcaAMz5jRZgqKLFKE8vUkSxs9QPlIE84nJV49TknpDfAtN8P471aNmDNsNGcAR3k7Y9o/DtjBTA
 tMrYFzrmmpBum9Lh9BQffOIxiQBOeRQydHrSWBPTjSYpaq/KtAGVA3dPzEAEXyHPyU8eLMomBCx
 V29RvFQ47rN7eRpC2Cw9DoFG7Eexb6ESaihm8xHzHEMPIHfrqgOGm/c2dgr9ww7/u7DOAAkchAl
 532DuYs6OmkhT2qWJ8FuGgIbdvzYjCaV/uC+cdolBXldN+UjZnmmWbprkhK3kJgx0N7m/YU+0Hv
 fG1TxmDlUcU141/9gVLSxzLCPjwxL+UiXg15Z6uMRrBskm41HF5+gSbqwqG17MoVW9918zfcWRq
 y8X1/yFkG60B4yoJIFJh22zlEKRCZmHoFU90AmU+A5i9OlfjvumHxFORzCozegM9bx8pLcVaHgF
 NT6z0aOWeSLbUPk/Bfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170062
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17-11-2026 15:09, Anandu Krishnan E wrote:
> fastrpc_invoke_send() takes a second reference on the invoke context
> before calling rpmsg_send(), to be dropped later by whichever side
> consumes the eventual DSP response: fastrpc_rpmsg_callback() for a
> real reply, via schedule_work(&ctx->put_work).
> 
> fastrpc_notify_users(), called from fastrpc_rpmsg_remove() when the
> rpmsg channel goes away (e.g. on subsystem restart), only completes
> each pending context with -EPIPE so its waiter can return - it never
> schedules the matching put. Since the channel is gone, no response
> will ever arrive to trigger it through the normal callback path
> either. Every context that was genuinely in flight (successfully
> sent, not yet answered) at the time of an SSR therefore leaks that
> second reference, and with it the context, its DMA maps, and the
> reference it holds on fl and cctx.
> 
> Schedule the same put_work that a real response would have
> triggered, exactly as fastrpc_rpmsg_callback() does. rpmsg guarantees
> .callback and .remove are mutually exclusive for a given device, so
> there is no concurrent real response that could race with this.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Cc: stable@kernel.org
> Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index bb0c304196..c5c3679f87 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2835,6 +2835,13 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
>  	list_for_each_entry(ctx, &user->pending, node) {
>  		ctx->retval = -EPIPE;
>  		complete(&ctx->work);
> +		/*
> +		 * fastrpc_invoke_send() took a second reference for the
> +		 * DSP response that will now never arrive since the
> +		 * channel is gone; schedule the matching put the same
> +		 * way a real response would via fastrpc_rpmsg_callback().
> +		 */
> +		schedule_work(&ctx->put_work);
Can you check the sashiko comment?

https://lore.kernel.org/all/sashiko-outbox-218551@kernel.org/

>  	}
>  	spin_unlock(&user->lock);
>  }
> 

