Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FF7C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:47:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C56310F24C;
	Fri, 28 Aug 2026 05:47:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.b="dNftp+Gv";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D748110F247
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:47:44 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so786750a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 22:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1787896064; x=1788500864; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5Zt5PXljQJqHa8ejgOjMYryQAjVgVBZDMdimKNGAGng=;
 b=dNftp+Gvphtl3wdwHIOvKvFq04tLemvWBK1ZgWky4/aY44vFzs1YhC6LZ5+tA3PMPW
 dtCdZ37raodCLNXjWS7bhXKjobUh+fCE3XlJLUFsc0ZktUUwdCipQzuTGkEkdc2hV9KJ
 b+BSGaxQOe0J0Q9e/GgrP76DRE5mapc0olQGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787896064; x=1788500864;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5Zt5PXljQJqHa8ejgOjMYryQAjVgVBZDMdimKNGAGng=;
 b=CtevaV1w2UNri2TpKmNOii1nna8oxDFNv0z69n8NhkHmM5uwkbwvX+atSYXFpacJ5K
 TMGGrPjsjiCyrtNyohpOSyw7o9ppHkCcey5m/wP0WeN3UDVFoTiYqYpK0y4x6xGcTy+f
 PV0yoZdvZexGlYse8dXI5uXQuBi3ZNKaEuZCeLresPQsEM98ZC8sVovk/fpXCbvlnb3W
 nF34D7SOd0yZoAb0NNdrvTOg916ccSpk3KSkmjqBrXHEfDXBSnHo0FSz4IKdBCxHH8ny
 ZiaYPfJmb7TpzjEii//RSO0hJLDbEavQiZwyYYRyhnGcuBrqDeYtdVAKtPms8RwkMa9I
 j4/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoU6J6s3Y5z4z/ue1FUaulI9TTF99UtL2IvoKx2TVz4qoNmCcjMYrkXW8iIuC3Q041RhDr9t+2VZgo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mP3hHXhSK2eAixCpV9kkKxRLn0QopNSHhvQVO239U0jKScI47S
 I7qgUeZRBMEe2KDbaRWM0jTN8oiWwDjNHUPZ6zKD/wjo7+7IRZI9US+geT1iMuKthSY=
X-Gm-Gg: AR+sD135YsW7OWOXct4fVd9xpo7W+P+5z/UrknBA3sMAZADRmBkry8FaYJjNWTZPC1w
 Fo7hshRPtWDDIWF45TAsTRQ3J1RHNAzk8GCO6vTloTfOemmNA9W2RJyxVC4crcQxLZMItSaNN8r
 WpILXCJ5CUr5uDa6mz+Amfc2WuU6REzCBMLBuUGJwpgq2u0JzKzh37duuJ15KG8UCND4pZiEIQ2
 8okHX6DO9L/jfk38lgdyVRbkiCBRsMZN/XBqu/eRpsSoRfYG6s8+S9rwJfDssjP+I+lPu4727lR
 wHumiYj/kwG4+9k9CcXuN6B6lPiOBDrKggwKugdtVD5lWIDESUWXsmfYM5O5/6xju3SNEt0KqNp
 8tgLSwWkLS+IZcM4eKRSUSYCWMLhZ8nTGWMX5cLe4ailCIfkcv9Rues7hRm1KPkMhQZZIAmliPW
 5YwBbCJm03a/3o3+hz7YxCtr8LEJOKe7AaiDrjGQCVVG/9XvgNd8FB3d7WibxxAmE=
X-Received: by 2002:a17:90b:37cc:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-396d0d92d0amr9519889a91.1.1787896064320; 
 Thu, 27 Aug 2026 22:47:44 -0700 (PDT)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b1992e05sm5740448a91.15.2026.08.27.22.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 22:47:43 -0700 (PDT)
Date: Fri, 28 Aug 2026 14:47:29 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: MoGGuU <Naixumogu@whut.edu.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] accel/rocket: Propagate job submission errors
Message-ID: <apEguR4JBTEvsHds@rock-5b-plus>
References: <20260828050805.38548-1-Naixumogu@whut.edu.cn>
 <20260828050805.38548-4-Naixumogu@whut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828050805.38548-4-Naixumogu@whut.edu.cn>
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

On Fri, Aug 28, 2026 at 01:08:05PM +0800, MoGGuU wrote:
> rocket_ioctl_submit() discards each job's return value and reports success
> even when every job fails.
> 
> Return the first error and stop submitting the remaining jobs. Jobs queued
> before an error remain queued, giving the ioctl ordered partial-submit
> semantics.
> 
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Cc: stable@vger.kernel.org

I'm afraid that this patch changes userspace API. After this patch, userspace
programs get an error on submit. So it seems that the stable tag should be
dropped.

> Tested-by: Sidong Yang <sidong.yang@furiosa.ai>
> Signed-off-by: MoGGuU <Naixumogu@whut.edu.cn>
> ---
>  drivers/accel/rocket/rocket_job.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index b55e12aecfe64..8f1bdf4a57f20 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -646,8 +646,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
>  	}
>  
>  
> -	for (i = 0; i < args->job_count; i++)
> -		rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +	for (i = 0; i < args->job_count; i++) {
> +		ret = rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +		if (ret)
> +			goto exit;
> +	}
>  
>  exit:
>  	kvfree(jobs);
> -- 
> 2.43.0
> 

Reviewed-by: Sidong Yang <sidong.yang@furiosa.ai>
