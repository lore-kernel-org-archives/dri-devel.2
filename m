Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8FE606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 04:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=ng1BTWrX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED12310E681;
	Fri, 20 Nov 2026 04:19:32 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A337110E2CF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 04:19:26 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-36dbde64409so682384eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 20:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1795148366; x=1795753166; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MU5DDe8WPNLGbF0itjuTQ81vCKFzjS+1XQz059WZL8I=;
 b=ng1BTWrXK6iiYaIEg1yCxmQO4rFPe919IGrKgksmEhH+pmahu/bPvXgm/FmbUNB9C5
 /I+E8ggjHK3tA7jmfFCYZQ1mdn76C+HRFhVgzFIWetpuhxSqve0V0Md6t8ZPa249EBZB
 kdJuBoFWT2M7Cfld6dC9RuurDV2knGE47Zklo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795148366; x=1795753166;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MU5DDe8WPNLGbF0itjuTQ81vCKFzjS+1XQz059WZL8I=;
 b=n717hUT9k0+eV/ujtRyzjJmlIfqFPft/fxnYKIE9QI3THVps5eIw5Q7jLdJXQ5bmsc
 0sZSw2LHDpon2++wmVLKmT93520CkqoOUzhwG8tcxjZkkx0BKkZ/rZtsBBNyi+WOkzIT
 HD6w3xV4qBrd9va7cPuYfnVr7xVu6IPXewKUa2NCd4asOEF0IySpj+UB4DR8ERn9FPy5
 PsjelInMSI+D08YU3mdWdpa3N3b2iuTiboKm6dL+0cse9lguFXxATmTIvOKXr28/s+M9
 vqVDSTd6qsNi9ICqL/O9hHYN7U8YZQhPeOMrBOh2ohV8AMPnBBMNJbRuH9dDxSlDk/f+
 OjMw==
X-Forwarded-Encrypted: i=1;
 AL+hErEyKiXpmVff4dsLQXqMGjFPmQHKFjjgD8GpA4azcTQnsa2M0wJWtTrYixN7m89WprdYDnK5PmONOmc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Db3JdCjEXy0BCbYGNDNfNjHd4JYb/Lpjp2VImPgL5HJjJCtol
 7FXzgQ1Wa91u80YgfJbQiDz8ZVFu5AdaeqVuhRTQXybpemP4Wui8h7aPmIE5Y2F/xY4=
X-Gm-Gg: AZFdTZdHCeq6yJLMPLhcdk1m4XmQ8TyybtIqhX1KQci3eOrf4HpTWW7hajDl6Zn3C/p
 snSojLOJn3pIzY3hOFXioNu5Sm0V8xdP93JoLuUpxVcP/Ym4I6ZLDYaLi8NIWQWeKWd7LgBBm+U
 uuO4DarmRx0KPb1SdZumUX1EGoupse+GKvfLA9730dvYGdbS0e7oIelnUX36tRxXdPfh7aiCRbX
 KK2WOCQ7crTtz85pbHkd/a/X7EcBQ7BqhJvIqB7jA5L+/5yoO4Lox/Y/A99pyjCI9oBZjeeaGkO
 Yyldr+J/IFmxFGEgJoo5Noh0PgVAYg6IZGLzdfsrf9MOYh8BiOb4bylAR9jeyimd1ipwhYDtgS2
 v5JU7YqobFezJfjAoKNNvb+VQs+CrYvyXiVYT4uBvKlvGi7thpCs4g/A4YSEHOQiF98HJvPSZDI
 eQl8SLbTTSs5IA05yrzaw5relbrginXxIGbJZM/qrEqsz7upPyItvzEB3CNtnysMxJXAN4udQ8l
 nT7BKLX80hcBcBCMylwCYzA5qYFFl7bYel/MPuhvd9NALo0enPwlM1lQIBlR9Ri5YI/JgPhKhV9
 rdLkWG4QeD++WweCxZ6NuSCV0xTSe+htRsLWVG/LfmPtk7sv34nLgiq7VBP5lTaD1ro7M55QDHW
 JfNVe2l50YjPR
X-Received: by 2002:a05:7300:50fa:b0:384:6487:b155 with SMTP id
 5a478bee46e88-38570c359d3mr1744166eec.29.1795148365941; 
 Thu, 19 Nov 2026 20:19:25 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e99fdsm4107967eec.5.2026.11.19.20.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 20:19:25 -0800 (PST)
Date: Fri, 20 Nov 2026 13:19:07 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Heiko Stuebner <heiko@sntech.de>, Gyeyoung Baek <gye976@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] accel/rocket: Report NPU usage through fdinfo
Message-ID: <av_KNIsnvL4GXCGu@rock-5b-plus>
References: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
 <20261112171144.3151554-3-sidong.yang@furiosa.ai>
 <3c5f7694-e6fe-477d-bfeb-a130c363f431@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c5f7694-e6fe-477d-bfeb-a130c363f431@igalia.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 09:31:54AM -0300, Maíra Canal wrote:
> > + drm_printf(p, "drm-engine-capacity-npu:\t%u\n", rdev->max_cores);
>
> Does it make sense to expose the capacity of a core that it's not
> actually initialized and in use?

Thanks, you're right. I'll report rdev->num_cores, the cores that are
actually bound, in v6.

Thanks,
Sidong
