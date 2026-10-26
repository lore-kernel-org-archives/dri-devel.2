Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6CB606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dHGz5gWj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EDE910EDF2;
	Mon, 26 Oct 2026 10:29:25 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 315BD10ED96
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 10:29:19 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1352361f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793010557; x=1793615357; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X80l1ktYVTyzYo/RbFVbsXtNEdr+d/QH53RjktV2YY8=;
 b=dHGz5gWj0DPEak4cUjXkPr22u6jqEWRbbYshYlftOjOiJJtcTDtUvJQ1WM4rSanLbX
 uLCxnh00eePM+4nd7opDYjX8+6O57ke7TnCeHtxir7lW68HMKyT/yK9JC+kWExoTz6Fh
 MWZzQGaGOHHmNQ3r9J4JgItr+0Ft4EdvQBMsC5P6eNkoOCDkSPmiiQ0AhbLTwvYQsRyi
 3UqZ6YvLRbgfF5cA0bCvIEQfSkvrJY9HMukSwwcPc4yQ4EH6P0vSB3XtfdAg+S9E6ogD
 5SmS/jxuXu3fpIagJQCVnIkCFblb7/hYPT4cnmhGECTrv2WioSw/nyI0DW2fziBjPJq3
 HQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793010557; x=1793615357;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X80l1ktYVTyzYo/RbFVbsXtNEdr+d/QH53RjktV2YY8=;
 b=X9Bb6KNg1p46pjJf3qbd46NQ00Fk9vvlrpdCXBm6W39rYWRlLqAes7NTVXQOrJHAut
 a1JnFr1DEYstX6uxJUEIu/H/Mdxn5Uv10wLX/FJ0WxIC+nOVWQrHS+jgamfqQk+yz3y0
 zK0H+aQqvTamcdvSPdpRvTenzrwQzfwfATQ/un+EzB3Y9+RsLBHl5Nj/lzO4kBiYOnCs
 uiYt0BOWSOAVQ5wS898iF5Qk000oML+llybcm2JCMyKPWhgDQADS9xLTYoANIXHykWMU
 m3gT75vUEtFUKAHchgfdYwRDeg+zT2wMYrCNqOBkWW3OVB4nCyg2YHufkEnLDBoP9aYi
 1gFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHdlPXu3n45cvas8XDyn5qNnxuuRn2t5eKXWRQRMe0s4wFEUbDdcnrG1EKiXvfnPbhwv5v5lE01DE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKantLrPlFDu71+rLWgJ4U8Kf3d42b0PaQHrcsNSvOyWuluUahE
 YlxbK6rU4fOgYT1+n070q2Vt8DzAXE54m/zAL6Wl6HHaxMD1yeCIN/Py
X-Gm-Gg: AYBFou0cgRLZQXVN9Wfev/o5AN9fAzCRek0YliGCUnmGryEJ0MTebWbCCxhOCEUH8U2
 zed7/sL4O2Fy2FiGYyCL1O05diaThO8L4l0988G3TRzTkgedRA5NF+bvYlDJYwYLVPA0sK++9g5
 6LKgjcbVrkzq+4Vyar662+lrWRSkt89iYBJw1jT5M7+vOkXHCI1Wa6tSZAdGbHnfO1VtygsQ6aR
 bOtYpjqX1Ab1SCzZBS/F0MfMuX2cFrgRO8YNxI7ZaQFV8APlMuM0Lef1QBkpRoc2IfzHC1PBotL
 gwgh5ZQ9WocyuVRu/DTp905T2PawfndsLZm7CyFeWfvQPLmlzI/NZdEcs3cu2sojEua6hIJcFIX
 a7WGrWvZ+MVNqfOnB3RRVgXYuW+fml+cI2VXuMbPxm1+CaxLrLWeJLbKeY+fKvB4BdXxyQex0p+
 lgJ/V4pKN+MltbNE9rs86lhC1Jwnf3cp0Q5K1MFnQpMs7PBepbbvyo9GPVkUmVF0TriV6rPhQAm
 mA8ZDHlqS9tq+d9H/QWNsX3M8IcHbqRJiyRqz/SbJh7tBYOtfGEiQuzQrOdg06lU9JvsvfYDg==
X-Received: by 2002:a05:6000:98f:b0:48b:db7:86a7 with SMTP id
 ffacd0b85a97d-48e3eba5d2fmr12088523f8f.50.1793010557470; 
 Mon, 26 Oct 2026 03:29:17 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48eesm15574100f8f.30.2026.10.26.03.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:29:16 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:29:13 +0300
From: Dan Carpenter <error27@gmail.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
 cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: fbtft: remove unused fbtft_init_dbg()
Message-ID: <at8reTB8v7iU-IaT@stanley.mountain>
References: <20261026101815.73722-1-himanshu.bakshi478@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026101815.73722-1-himanshu.bakshi478@gmail.com>
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

Please always wait a day between resends...

regards,
dan carpenter

