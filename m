Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441CCC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E88110E33E;
	Mon,  6 Jul 2026 09:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FWRXUOwp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B45A10E33E
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 09:50:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B84E60018;
 Mon,  6 Jul 2026 09:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07741F000E9;
 Mon,  6 Jul 2026 09:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783331433;
 bh=26afmC+0uDztCMWGBbLw38W2d/S18afQ32VhOWo1JuU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=FWRXUOwpqML/DT11JKz2N5//x3ZZkARcxS34xp4O+CBxIg+LXDAkIY4H2/8iR/nLj
 HI/iaTqI9NUtinMndsxpxZY0NtwVxxsPwHW8hiRZNdNwrFUJHyQmuuJtrSk8TY4GCt
 46EnhV/Wtq7UvN3dUVReFjXB7elMZA5wUn+7O0d+6VhFGNxvpLJ2gzt3Ztbi03pET7
 yH8rY+Bp628wzK7rvEAQxxDlsjlNz66G8ngsYsOn0zHT0srMD7EycU7C6Egz5Id8yB
 BHPh+agRGzUPd0nDejFoKHC1esInfFrYeWkrTh+uZ8Q03RsPbSxs6IE5VJICngLa/s
 Bq+W2KEAD31Dw==
Message-ID: <6766c138-90cd-4be2-80c1-0f5c144252ef@kernel.org>
Date: Mon, 6 Jul 2026 10:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: fastrpc: add missing MODULE_DEVICE_TABLE()
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260705001820.72397-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260705001820.72397-1-pengpeng@iscas.ac.cn>
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



On 7/5/26 1:18 AM, Pengpeng Hou wrote:
> The driver has a match table for the of bus wired into its driver
> structure, but the table is not exported with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE() entry so module alias information
> is generated for automatic module loading.

Are you fixing a real issue?
Is this patch tested?
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the driver registration structure, and the missing module alias
> publication.
> 

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/misc/fastrpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 47356a5d5804..0d2196b3f632 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2265,6 +2265,7 @@ static const struct of_device_id fastrpc_match_table[] = {
>  	{ .compatible = "qcom,fastrpc-compute-cb", },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, fastrpc_match_table);

This is adding dead code, these devices are created dynamically by
fastrpc driver and does not have a standalone driver.

There is already a MODULE_DEVICE_TABLE for this driver.

--srini

>  
>  static struct platform_driver fastrpc_cb_driver = {
>  	.probe = fastrpc_cb_probe,

