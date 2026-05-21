Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD83CD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 18:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 326F410E1C9;
	Thu, 21 May 2026 18:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WwB6l55R";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66D2E10E1C9
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 18:28:52 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso5867480a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1779388131; x=1779992931;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0XQG/6g75fgxZbBE/+qTXKYgHicOF73Gp8SX+DuZdw=;
 b=WwB6l55RXJG+UCkrFWhiGa/Np4a8NX06uZejCH05903JR2Jj6gQ/fBgPUA17a7vXxd
 eYP+zEdqTnkh9dPf7z8DpGLow8itxJz+UQ0FbyoyjZfJEuU/nrW9n4jDQk/CpFN4MG7r
 pLIgx3QwOTIYMeluqfezBA4J+L8xiR/ZHmOPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779388131; x=1779992931;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G0XQG/6g75fgxZbBE/+qTXKYgHicOF73Gp8SX+DuZdw=;
 b=o09lPJpqT0Mr4qwX3Kco4sLGpOD3vCQG6sS7fxXCuAZHBcIHs/1I30UDLR529YBhwU
 Gk4npoy20HxeRrT16NF6V/AQMgO9gBrhNWSl21PWRZ04jKqBLQOkFhZhXQDawYcy3Lbs
 XSrtOjKyKLPpx1U+YetKP1yYIlysAshCJtiYxfqvP81zQLht8vgRkLNjxi3mWV3AvlsG
 DFJb5bDztwi6h6OynLrqzyH7n9vV2JhcN2QcAlJ3oyzLsJUcqvPZ8hvdp2cDSmidGDNk
 /fdiPhWujzzT6XD6cKI7f8VI2QNzapI9BcX+W3xpxcTyOkLAcBiB9zAr1jgoWgEOpftk
 e+cw==
X-Gm-Message-State: AOJu0Yz16+u8WzMKnxMiNH/9QTbNVnqvJXbFH1eyJbaIRZ/DmPA0J7yM
 L3gkX3HR/Yr+6lbOPapFvqU6Qql/zBgUlP5v4QANdr30neDh8Z3XHqYkcaXdqUomOSI=
X-Gm-Gg: Acq92OEltPgojq/kcnTaY0grjerOiYA3KwticgXv27U5mco+RCUsUoZYA7Qa2OQbLjC
 7jXCYbyirhLoMbGWdnTBm9DR8ohSGOZCAeoJVJleL1UIowYqCH0VH19jFEtMR3plxsuQG7ZJd0o
 mTLxiYYhblEFOECXBNRBAL9Bv9eItOwcxNXfeablOKRLik/iy+9VDkGXj9eDbF+8y7Ikad+wtPQ
 DBBdFRK5T6zyOyt2M7bIeUjJ9hW0r8FwZJGmhu0NxdCEjCblfQxXo7PJSdlnbu1OmaHUbDzN93l
 TaCyEqWlFEv/e9xrKSA2txY7MYEn1Yl12KF8PMRpp60k79T8ek+BYNDdQaJr+tPIR629vDesyiZ
 xoCOCwzU0AQxpREbucTqbOmZ0CGsZea1foy4j9fEgaLokmbFG4yP/C8/OFC0FouwiP7vUhM4h0K
 TzT0E89ZOcCfFu8nBMCALEpbGDnHyQfowUdH0I9mcQGeFWZYThYRbPC+HcaEb5Me810nd2FpZ/N
 +vL/eQ5u4XcePo5bTvweRRYpM7aXKh96/yzojP3PrC1bA==
X-Received: by 2002:a05:6830:6d0c:b0:7d7:ed69:81b2 with SMTP id
 46e09a7af769-7e5fed2964emr243419a34.5.1779388131456; 
 Thu, 21 May 2026 11:28:51 -0700 (PDT)
Received: from [192.168.1.239]
 (207-181-222-53.s5939.c3-0.hnc-cbr1.chi-hnc.il.cable.rcncustomer.com.
 [207.181.222.53]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6e78bf9sm930694a34.15.2026.05.21.11.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 11:28:50 -0700 (PDT)
Message-ID: <e81f9c62-b6ae-409d-a5a1-246bc7f9aa23@linuxfoundation.org>
Date: Thu, 21 May 2026 12:28:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: gpu: todo: fix spelling of "fucntion"
To: Godswill Onwusilike <onwusilikegodswill@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260516210141.42971-1-onwusilikegodswill@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260516210141.42971-1-onwusilikegodswill@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/16/26 15:01, Godswill Onwusilike wrote:
> Correct the spelling of "fucntion" to "function" in todo.rst
> documentation
> 
> Signed-off-by: Godswill Onwusilike <onwusilikegodswill@gmail.com>
> ---
>   Documentation/gpu/todo.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index 841e4e986c48..7526ed31b0af 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -1001,4 +1001,4 @@ DRM driver that can run X11 and Weston.
>   
>   Contact: Thomas Zimmermann <tzimmermann@suse.de>
>   
> -Level: Advanced
> +Level: Advanced
> \ No newline at end of file

Hmm. the patch doesn't fix the spelling in the following line mentioned
in the commit log. Instead it removes and adds the same line.

"rename all inlined fucntions according to driver conventions."

thanks,
-- Shuah

