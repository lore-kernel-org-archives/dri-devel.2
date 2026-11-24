Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388B4606A33B
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IsJGF4pn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA7010F4C0;
	Tue, 24 Nov 2026 11:14:39 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF1010F4F2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:14:34 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so34678645e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 03:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795518872; x=1796123672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ni/WocCyF1lCKcQ7aAS57++XN04zb2GMBdljwSeIWWw=;
 b=IsJGF4pnGS+CaF6KmFMlCLpGJd4pLuuvrTI7M9hwnrk3+iON+R6nFqq8GyCvYpGlOB
 hMYk6FVsOT/JQMo20xbK1PrTWOxNEHo3aLPluOGRZBsWE6yHaOVHDniafu1uCMgFmPhr
 PybEt+970v8V7tmTVy9BJZjR5HA/2pJHsJhhOR4wJnx0mrnm1TEpSBJb9zM2XcmaaPtY
 Z3vIc9wmIOIXzs/Wr+qt/fQVYV3GehgwErM/ABJvx2VACHoPhLT2DeBjljbxEjIdbCim
 M7q/24eS2ZqU/18jHWEi0dJehCYE80aADbm9K9csiqWWLFt1v3rIhlGqxGGspWebZ33F
 F4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795518872; x=1796123672;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ni/WocCyF1lCKcQ7aAS57++XN04zb2GMBdljwSeIWWw=;
 b=gjzbmb27/WyOvOCUxuRWvatLdlWE+lLhh2rK3mjD7lcN3JRB0sCRw3dyZ9tAp0lnaq
 ADnSmczrUT1bjLFuRqEO1c+PH7j1RbWmYPg8mITC5bHR3qKQ4dusfgzV/8B75ZEGkQKf
 dUEihHQNJON2kdaa8X5yZ5ZjeyueB+6BDmvuTn7T4J/KF7r6jTnZFuQK+IlOXVlJ5cVf
 nSOugrNoIH+6+GfkwOkVe5XzphMfrV5aeN2g3MzG4l78DA13sUGFigmEZYvtXftGlTDz
 I5C0QSRFz8ryt3tQEzrtUUXWcJgz8xUta6OLbqj7Z45zt4nhWTg2WnxqryHdIXpBA4D9
 XXIA==
X-Gm-Message-State: APuU4Z8rGyn4fofk00jADi2J3bFBxgP1VXyq8Nec9ye2KZUruaLgXdHc
 qdXV3OcM73BAVhsO7CxALjUlFA5NKU9cAuSS8eHcRpWpFodfG3yVecMU
X-Gm-Gg: AZFdTZcNqB5KbBc0P1cAwLwyUqVX8zmF7nL8rtOPxoGVMet+9qpcu+CCfNll0f7icFa
 TJekkhwHq+n12xOPO4GQsMD6JyJKDiL3GuU/k7R9HQbZ6t96Llm3IY1HY6ZXAnqaHscTBK/ermd
 YGh16OBrVsmsi8ZqHavMKZFBOELmZBX9l7ciPkd4JtMpQ7bR5jNEaUoONoQ+e4Nt17wqFUKLcAh
 BIopYAfCnev93mjN4UYvjIJ0DtPXJBpPvjXdw9KeTPKa/mq6TNoXBE0LUruWPgClXkf2rDfUiQG
 LGjuF0iuocdWpngPItP7SDacGHbE/ZY2h9R+LieicDlLYQ79jdHHocQ8xXdiihxtGD8imwPYTG6
 fkG3l8wb3z13EtcIzOtSVNfclK8WtldV1V6Qwxn2cRWa3kQWzkumn8jAxjX25VUqj0z8rTW38nc
 yIq/UIjWgVOaP+0I7JIaHDuh2f6kpqVDOQfUm5PpMvOkhhhxLnDTq/Tt+tzB1EBd8htcBf6rnGB
 QYMrISkfBbbJUCVA+Cibf2byS19n2u5L4sGv3NMMBpniBQ46H1CdtmmneNp4ASatl6Jab5CnSPw
 R8nUcVMymyUVWE/KxavM3nQ2AS5DqQk=
X-Received: by 2002:a05:600c:46d0:b0:4bb:7987:fbc4 with SMTP id
 5b1f17b1804b1-4bb88817eb2mr293835625e9.19.1795518872421; 
 Tue, 24 Nov 2026 03:14:32 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906635c7sm239716745e9.2.2026.11.24.03.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:14:31 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Karthik Sarvan <karthiks1mail@gmail.com>
Cc: dri-devel@lists.freedesktop.org, louis.chauvet@bootlin.com,
 tzimmermann@suse.de, melissa.srw@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH] drm/vkms: Add DRM_FORMAT_XBGR8888 support to writeback
Date: Tue, 24 Nov 2026 12:14:26 +0100
Message-ID: <awVxc0cix2z3pC8z@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124054953.39432-1-karthiks1mail@gmail.com>
References: <20261124054953.39432-1-karthiks1mail@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 11:19:53AM +0530, Karthik Sarvan wrote:
> VKMS planes already support reading DRM_FORMAT_XBGR8888, but writeback
> cannot write it yet. In the 8888 format family, writeback only supports
> ARGB8888, XRGB8888, and ABGR8888.
> 
> Add a pixel write function for XBGR8888 and include it in the supported
> writeback formats list so compositors and tests can capture frames in
> this format.
> 
> Signed-off-by: Karthik Sarvan <karthiks1mail@gmail.com>
> ---
>  drivers/gpu/drm/vkms/vkms_formats.c   | 10 ++++++++++
>  drivers/gpu/drm/vkms/vkms_writeback.c |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index 7f1f29b589e8..a89aef97cede 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -611,6 +611,14 @@ static void argb_u16_to_XRGB8888(u8 *out_pixel, const struct pixel_argb_u16 *in_
>  	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
>  }
>  
> +static void argb_u16_to_XBGR8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
> +{
> +	out_pixel[3] = 0xff;
> +	out_pixel[2] = DIV_ROUND_CLOSEST(in_pixel->b, 257);
> +	out_pixel[1] = DIV_ROUND_CLOSEST(in_pixel->g, 257);
> +	out_pixel[0] = DIV_ROUND_CLOSEST(in_pixel->r, 257);
> +}
> +
>  static void argb_u16_to_ABGR8888(u8 *out_pixel, const struct pixel_argb_u16 *in_pixel)
>  {
>  	out_pixel[3] = DIV_ROUND_CLOSEST(in_pixel->a, 257);
> @@ -977,6 +985,8 @@ pixel_write_t get_pixel_write_function(u32 format)
>  		return &argb_u16_to_ARGB8888;
>  	case DRM_FORMAT_XRGB8888:
>  		return &argb_u16_to_XRGB8888;
> +	case DRM_FORMAT_XBGR8888:
> +		return &argb_u16_to_XBGR8888;
>  	case DRM_FORMAT_ABGR8888:
>  		return &argb_u16_to_ABGR8888;
>  	case DRM_FORMAT_ARGB16161616:
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 858df1f89f66..3407b5914694 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -18,6 +18,7 @@
>  static const u32 vkms_wb_formats[] = {
>  	DRM_FORMAT_ARGB8888,
>  	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_XBGR8888,
>  	DRM_FORMAT_ABGR8888,
>  	DRM_FORMAT_XRGB16161616,
>  	DRM_FORMAT_ARGB16161616,
> -- 
> 2.56.0
> 

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
