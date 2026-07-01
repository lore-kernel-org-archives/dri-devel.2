Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880EAC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF0210E3F1;
	Wed,  1 Jul 2026 20:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gy8FXnjR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E7310E3F1
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 20:21:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF8D760138;
 Wed,  1 Jul 2026 20:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79931F000E9;
 Wed,  1 Jul 2026 20:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782937263;
 bh=I1MrHWNoePasAF89bOFkx3E+DQzJNV1VoJf4OgB1Qys=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=gy8FXnjRj2EIDzXAefjnJ+gxN1nxuartvvuZijND8toXIyijlieTf93gnuO/zyl21
 SDrHBf+HBAe5pIhmFjtdIlmDWOs7cs+kciFy6t4UujoXrOgd+G8Hyi3J7iN5k4padx
 IA6dqBqqKvP+0MkK6H/EmTDLrluICUEJOO8VjvLXrIVIKBs9rFVDVSeNxYlrglZbrJ
 ejK1AWp1lJ639oJi8hnuygEcF5coDuVzWpT1gN2RrJF7VuRSj0zJK4W3ZUgNCzlyyl
 LhKnZIu7lind/cU1E86YCdlf62pTuAazNPCBjnGAAeLm/p3t2HgkQbo7tPmtRDdNEv
 ifENFzG3opwag==
Message-ID: <6a7e3394-9dc7-4371-9935-47f3be8a59f4@kernel.org>
Date: Wed, 1 Jul 2026 21:21:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: create duplicate sessions after all CB
 probing
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Bharath Kumar <bkumar@qti.qualcomm.com>,
 Chenna Kesava Raju <chennak@qti.qualcomm.com>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
References: <20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260609-dup-sessions-v1-1-26934abb9fa3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/9/26 11:33 AM, Vinayak Katoch wrote:
> For ADSP, only a limited number of FastRPC context banks (CBs) are
> available. Each CB supports a single session, which means only a few
> processes can run on ADSP simultaneously. If all sessions are consumed
> by fastrpc daemons, no session remains available when a user application
> starts, causing the application to fail.
> 
> To address this limitation, a Device Tree change was used till now:
>   qcom,nsessions = <5>;
> 
You should mark this property as deprecated in dt bindings.
Which should discourage people to use this property.


> However, feedback from the upstream community indicated that this change
> should not be made in the Device Tree. Instead, it was recommended to
> handle this as a driver-level change.

Changing it in driver will make it applicable for all the SoCs.

> 
> Instead of duplicating sessions inline during fastrpc_cb_probe() using
> the qcom,nsessions DT property, defer duplication until after
> of_platform_populate() returns in fastrpc_rpmsg_probe(), at which point
> all compute-CB child nodes have been probed and the session array is
> fully populated.
> 
> For the ADSP domain, append FASTRPC_DUP_SESSIONS (4) copies of the
> last probed session once of_platform_populate() succeeds. This keeps
> the per-CB probe path simple and ensures duplicates are always derived
> from a stable, fully-initialised session state.
> 
> The qcom,nsessions DT property is no longer consumed by the driver; the
> binding and DT sources are left unchanged.
> 
> Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1080f9acf70a..46afbae9c234 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -30,6 +30,7 @@
>  #define CDSP_DOMAIN_ID (3)
>  #define GDSP_DOMAIN_ID (4)
>  #define FASTRPC_MAX_SESSIONS	14
> +#define FASTRPC_DUP_SESSIONS	4
>  #define FASTRPC_MAX_VMIDS	16
>  #define FASTRPC_ALIGN		128
>  #define FASTRPC_MAX_FDLIST	16
> @@ -2195,7 +2196,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	struct fastrpc_channel_ctx *cctx;
>  	struct fastrpc_session_ctx *sess;
>  	struct device *dev = &pdev->dev;
> -	int i, sessions = 0;
>  	unsigned long flags;
>  	int rc;
>  	u32 dma_bits;
> @@ -2204,8 +2204,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	if (!cctx)
>  		return -EINVAL;
>  
> -	of_property_read_u32(dev->of_node, "qcom,nsessions", &sessions);
> -
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	if (cctx->sesscount >= FASTRPC_MAX_SESSIONS) {
>  		dev_err(&pdev->dev, "too many sessions\n");
> @@ -2225,16 +2223,6 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
>  	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
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
> @@ -2445,6 +2433,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	if (err)
>  		goto err_deregister_fdev;
>  
> +	if (data->domain_id == ADSP_DOMAIN_ID && data->sesscount > 0) {
> +		struct fastrpc_session_ctx *last_sess;
> +		struct fastrpc_session_ctx *dup_sess;
> +		unsigned long flags;
> +		int i;
> +
> +		spin_lock_irqsave(&data->lock, flags);
> +		last_sess = &data->session[data->sesscount - 1];

Why only for last session?

This is now un conditionally done for ADSP which changes the whole
behaviour.

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
> ---
> base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
> change-id: 20260609-dup-sessions-ea2acaac1994
> 
> Best regards,

