Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C4B606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HU2TXrWV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C66410ED96;
	Mon, 26 Oct 2026 10:29:50 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C31F10ED96
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:29:43 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso1910831f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793010582; x=1793615382; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VZ9A0GT7Bc+iwj4opPu/rDKXsQb5fk01pBmT0V91WnI=;
 b=HU2TXrWV1Te+CTanU9rBV23FY21OaQGumHWMWEmLdKq5MD841Bhyniz8yTasIT8SvW
 HuXtWW85/JoEsabJI5HqoOXREJaSEt6kYLq8YKjf2cGxJFxeqkyn27HKHZ7NkgKPja/s
 34WQMbKwiy3yHKEKVv93FCDM+kEU6LSmAdDOdsvCV9/5xg0TRDbM64xTPMMhKgKLq0XA
 WWxhBbfpJQUm7+wqNsFl579SoYD1NqXnPUhCw9TCE7X6qtlXWayIUYiemEc8XZK2UDv0
 SQb7v/T/un1ok69+JneKtPS1cxkY9SbnXIaOmjKkwhPNt8fiO2qalS/2k+1XquJQTxEB
 FDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793010582; x=1793615382;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VZ9A0GT7Bc+iwj4opPu/rDKXsQb5fk01pBmT0V91WnI=;
 b=Q43pRmFRZdVAGzT8Xcn2lRoGW1x5Re8gYVQ+mr7zgaxnXz9S9mfnj8HHP8QwIFuUov
 l4PADdLny7F3IR5vpQ2xqbHIP9CjK797kGh3VmS6zzdGpdzZs5TWwRNXth8nmzrFPJX1
 DON6blz6t7V6ncCADPht0un4GWADtyPewUrqWI+pm5ZqXU2GFmwIuqEofAGbs4hkV4i2
 llPr7VQ5WaSH5EcEPt5zuJG+cCnbDupgoowu6G0RZxKCJ2eVytliCz8wI4NXQXTB7MHM
 xWTieL10Z+PXCfT0dc2aPwaQZDEqJ4pLhA70aNLdWLdiOxXpe+EZ0/QT3pE31F/IPXh6
 TMww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzW2z+OQI6pgoRZdc5NlE0lxAo15i2keoNK+WZI5396c9SFoWuG1ssi/iWFW2twjmL2GvFjL2RXvqM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK7YAxZ/TWS+rYRcZiywxmyEJCF0FH5Sqb0oHKkGeVZD61oahXI
 0ePNvQ1nokt6qiM6M9SDgPATyPutE85ykJ7A4nf0REx//9yktoDnapGz
X-Gm-Gg: AYBFou38Yaw40kf2TwTHlfP5qmZKtSSCv05GFIIRkJ5wUg3PnJSaXluATUT15nV5Cbj
 St6KQfwHuTbC3Wzu98zOvGYNOBXqWnbJI4hVXKH+MJsGssuo+2bO2pF6rttoZkFASBDF7ZfHI4H
 aZica7E9PfkgRPkucDX4xxHFBV2X1xF80R379IV1XtR2IIRkp2ceaNcSZ+8i63hQUCGwZZEHx7m
 JWoBiB8fhRgC3f2pORiTEOZtv1Fe/A95tfZ8egkdWaNZSrvuZlnCGg7GTdt55pMte7PvOG7ivTv
 dtyuihmD5lNr5X5LHFXo1j9xqahhuK0oBvuHTB9zXPaoPkAPky59g2M40NVACaKxwvvxRC1HV0z
 KaG+xWtogT4yclu8zARVdblMz85HYz5sfABy9z9N+cD9AoQ375wx/mEumNoQReX/71Bjw+a7HKa
 tNUw8jDhbYYpD3sNFxQnfOcWXQ97j9hONfse4aFaYJSIW/XBk8DY/P/m2KxnFjWqf/Tr0tECGt5
 Ll5fZDNXijRJH4dB9sF7LHsLsMInrFyaUgKF+l1ahwxeHOAsE5NkXRlvWgY6UKl9HZpwWCLDg==
X-Received: by 2002:a05:600c:6095:b0:49f:fdca:c361 with SMTP id
 5b1f17b1804b1-4a35ac99412mr100451485e9.12.1793010581925; 
 Mon, 26 Oct 2026 03:29:41 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f4f20dsm129772185e9.0.2026.10.26.03.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:29:41 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:29:37 +0300
From: Dan Carpenter <error27@gmail.com>
To: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
Message-ID: <at8rkdbWrz6uei6K@stanley.mountain>
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
 <at8lztOr7xpvHEdo@stanley.mountain>
 <CAGLmz9KAs7oKnmLv8NK6Z8yBQyrdV41oiouoRrNBY-j-p_H2+g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGLmz9KAs7oKnmLv8NK6Z8yBQyrdV41oiouoRrNBY-j-p_H2+g@mail.gmail.com>
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 03:52:43PM +0530, Himanshu Bakshi wrote:
> Hi Dan,
> 
> Thanks for letting me know. I have already
> sent the v3 patch, so I apologize for not waiting for
> a day. I will keep it in mind.

Thanks.

regards,
dan carpenter

