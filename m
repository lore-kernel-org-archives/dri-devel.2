Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF62606BA68
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=qFkd1zi1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3D2D10F4C1;
	Tue,  3 Nov 2026 10:43:50 +0000 (UTC)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BBE910F4C1
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 10:43:44 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1adbf62dd31so4365108c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 02:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1793702623; x=1794307423; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KYGsm00/gcmN5SQP6MqBGrok4btxYpgwkWC17qctOHI=;
 b=qFkd1zi1xSmHi2Hn14eKPu9xLyys6Ju4UuRpsGg/R+jguykeFL7nmjEBxlKaJcvW9p
 9DuaWDQDdFuRFMgGYTm37zbC+NeIyGwKZLP5KY3caJr1py9FnheqA358JPmv813KKQKh
 NDtjuvQhgmytpNFgK8DDISny6eS8Txqn1bW0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793702623; x=1794307423;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KYGsm00/gcmN5SQP6MqBGrok4btxYpgwkWC17qctOHI=;
 b=o/XVwWWxqI59nxFkyHRaaWYmiUCxo33n4HPhBUHUhPn2AMbSfeafiEUxUKcMBMcEWs
 6cF49zRfPz9azxkmDF4mNGtU7LXhHepJy2mxFRdQgVSLGIWyV5ly5QWiCjxtHWlo0vPK
 DvEjECsJWj7yCM6aO0Vq8aEw58CQUBS1QP50SJ5gdRAOmMg4HsqGZGBNf0+Jz77vGbgx
 po6+1/OtQ6g5LAgMTMHWL2qontKYctirmMhABDIIHX2murV11jsHDoVYanwJUBpwrqOw
 TUbHDbmhv8OnybPMRyCSSWaGw2HJOq1+NdWoACdVgOzxhCt7XLO6xtI4utrvyrh6S/c9
 5hLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEosCiq0SMC3bQs9RH3vXv8W0T9n1nwqeMywuJX+ZohWd164IrVKmA2SaMSQtZSmWPPj+hTiqAAUU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+P4CY2Q/SteejR04/g8apVikKK4vUgp+UbM5uIfEi1AxCes0FE
 K/dzz0LUEVRc1ODh0EJ+NfrjHkzaDnOZ5bxLuMfF4Sst1vqsWrWOODkeegeV598iG0k=
X-Gm-Gg: AYBFou2HO/2QW2lf65sMz8xp95joog/5dkIXJekXQTA8Pp9FebIX9rkzhj6bxwyKhry
 sTM8U6eGWsRHqOcphJUNQhYxg9W9iZL/iIaDEFMCG0I7g8Tq6fL9GiZFCTkyKsAHBGyvLStz2XQ
 +K0SpRc69I9rppucN26oJMPRvywXCdbKbKkQ8ahgrJWXkylHqTZ0h6K7nvFNa2bfFrfIeEF+BTR
 0u0RpWeUzl2nSy8sznk7ezOei5s7CbXg+OKrnTkNjm9ZqS/92jmbkxovLybmW4nKBhht2ZfipEw
 PIHV8OMx3G/e/oWGk/dfHxCD/UFc+jcf3sB9YFk2yHinaNNEpOZEOkr4gWQfnxzvxhRkN4cS1vC
 4pL3W7TVKs+yKrA0oQIaGSlz+bb4Etuix/GDG5uNHB6ttwRcEg32zcU2Ui2NKil6QViMPUrLiUk
 WQJ92UMzQQVJ9PdYB92RBx8ggf7vSVhZymC5QkRMIBiHQaVwhfCBKEYKCkXIYWdulIRk2FClzMF
 Uz4f8VqI1rJ9idJdh2zeV/Od+FzwZ+g8MiyH3UjZ5QGfn48iw5mr+5q0GjJLXZXXz9hAT4ILJ5q
 r6oxWI1LFULvpRMcsxVeEYa79lvrlA==
X-Received: by 2002:a05:701b:4248:20b0:1a1:c1e3:1ec with SMTP id
 a92af1059eb24-1ac5ecb684emr19651737c88.46.1793702623204; 
 Tue, 03 Nov 2026 02:43:43 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac1854da78sm55034455c88.6.2026.11.03.02.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:43:42 -0800 (PST)
Date: Tue, 3 Nov 2026 19:43:20 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] accel/rocket: Report per-core engine usage through
 fdinfo
Message-ID: <aum6YsBrHFp29gQA@rock-5b-plus>
References: <20261101152723.1430312-1-sidong.yang@furiosa.ai>
 <CAKbEznv0ApgORxJO8BQY+XeDC94dqHz3GmdojwV7E7bdOCwo4Q@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKbEznv0ApgORxJO8BQY+XeDC94dqHz3GmdojwV7E7bdOCwo4Q@mail.gmail.com>
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 07:14:14PM +0900, Gyeyoung Baek wrote:
> Hi Sidong,
> 
> > +
> >  static int
> >  rocket_open(struct drm_device *dev, struct drm_file *file)
> >  {
> > @@ -86,10 +107,19 @@ rocket_open(struct drm_device *dev, struct drm_file *file)
> >         }
> >
> >         rocket_priv->rdev = rdev;
> > +
> > +       rocket_priv->engine_usage = kzalloc_flex(*rocket_priv->engine_usage,
> > +                                                elapsed_ns, rdev->max_cores);
> > +       if (!rocket_priv->engine_usage) {
> > +               ret = -ENOMEM;
> > +               goto err_free;
> > +       }
> > +       kref_init(&rocket_priv->engine_usage->kref);
> 
> How about moving these lines into a rocket_engine_usage_create() helper, to pair
> with rocket_engine_usage_destroy()?

Sure, I'll make it for v3.

Thanks,
Sidong
> 
> Otherwise LGTM. Tested on RK3588 (ROCK 5B) with KASAN: the OOB from v1 no
> longer reproduces, and drm-engine-npu* times are accounted as expected
> while running benchmark_model with teflon.
> 
> Reviewed-by: Gyeyoung Baek <gye976@gmail.com>
> Tested-by: Gyeyoung Baek <gye976@gmail.com>
> 
> -- 
> Thanks,
> Gyeyoung
