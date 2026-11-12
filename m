Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D75606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA8BF10E6AC;
	Thu, 12 Nov 2026 21:17:39 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5687710E6AC
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 21:17:39 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-8b0cf2c0785so4134057b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518258; x=1795123058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d6JR+CmGDtktkPY6hZWyZfZDHE67mDU8tPqqFiCe8dE=;
 b=IivOZoIXvE/6wli2q+lTMbm9tuuIt8bWf2EH9cuoFo5/MmGpx1Ea1zo619GMMF0EYN
 9ZvGiNFObpGZm9I3VUiCAabKzIyZFheJ/Sy85ro+8oMnGyz7FnfbiQM+RR1xZ1Mya2/n
 RlQxtzeYYr0c9ybJ09t5s0ZeaH/nkIZETwtSgx4xoqSu0Dss9VZ//Q7Nf90Tg8gVhEV3
 F3apB8SalOnjGWSaYUAMzY6UOsHgO7PbIF4cr20PTWBAGrTnqIlb/P70TnWt8erK7J5B
 ypr/kD37JwSCx9dko/S12s1+iU7HaLCHWTrrY3+TaYbBX6aPhs/1MvZ/4VHUMs9K7fFw
 JmVw==
X-Forwarded-Encrypted: i=1;
 AL+hErHhsY9CrdCBDu1DfX9Vd1jD0rD5CWgWxAZk73KeGr/xShvuxlVipncpOO2FCJrBc2j6nrtr47XxoiU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/aNMDYLb0k8zPS7zkHfiDvzxdQuOFjELCWb0MLAoco7gnkwvf8
 26p8uiEtMppeawDnWHYoABI1c+P1yTdJ1+HqBw8iHv0lSRqGgAOm76o/
X-Gm-Gg: AYBFou3EMkYynBudAzAwKT2GnFd0vOlRsWhZb38tPcUdPVyNFQt/Hg/7WYv0bDrqcUB
 H8I5QsLl46FRSZYb4eeMgsRzYeGO1dVDv2rStDMYBeOuKF3/hwV+AcCo8oc+5zO2BljM9apIWk+
 FIqQnkg3fHJgk2HvUP6poj2fPiF/5kIpvyqhpUu6L17KFBwjNdGid0P5UYHIV3C+gVi7XzW6LEx
 9R5I25Y9lR5rgBke1FMa1zjRFk+r3lJo5hv45UUinWupLo/XrjWY8fOyYI5iO8ek+bfAt92RgFF
 aGG15nK6ai6Tc8/mNrZfx7NdCMjq/CRuheNnb4YQqrw/14y95UvttWQ7XUj/2aCas2bWUEuPIxf
 ej+VgFbYrWIfQS3o6otGQ59//56rdCkY+db/PvO4AzjkQwl0yqasbe1t5TKce/J67cfKfGdW3iX
 i+8DnO29igI6c+pcRiansa9hBUpTKf2qzQzEKCaQqLoFsqfWQCkm9M7tVLHOh6ZK2tGqodsrMJO
 3DJw9dgGX7gqOcvw7Df0FaegZeON5K+sOMmWLAbsb5eCD4zz6HK0XMr3cwmyNK1XEl3nuctvfmt
 QaCSWjCYxiQbh+RXlWkUZUQl8+AnHKs4rX+UnUmV22l9C/QlSUL8PL+E5X83dg5dzp6lgF/Cqad
 oa9cSYeuo9oIedIdh0W0wS+T7Tj3g8q4kV6+3r0vZR9x0EyhbMYmqoQ==
X-Received: by 2002:a05:690c:6987:b0:8a4:d87f:8d52 with SMTP id
 00721157ae682-8b4aa0caf14mr4329267b3.2.1794518258199; 
 Thu, 12 Nov 2026 13:17:38 -0800 (PST)
Received: from localhost.localdomain ([71.68.170.161])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa9dc1c9sm5323407b3.36.2026.11.12.13.17.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Nov 2026 13:17:37 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
To: Gabriel Gama <operatingsystemsdepression@gmail.com>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v2 2/6] drm/gma500: do not underflow an unpinned GEM
 object
Date: Thu, 12 Nov 2026 16:17:31 -0500
Message-ID: <20261112211731.9997-1-joseph@telaak.dev>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261109063303.32658-3-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
 <20261109063303.32658-3-operatingsystemsdepression@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 09, 2026 at 03:32:59AM -0300, Gabriel Gama wrote:
> -	WARN_ON(!pobj->in_gart);
> +	if (WARN_ON(!pobj->in_gart))
> +		goto out;

Looks right to me: in_gart is an int, so an unbalanced unpin took it to
-1 and the next pin skipped the page and mapping setup. goto out still
drops the reservation lock.

Small nit: drm_WARN_ON(dev, ...) would match the drm_WARN_ONCE() just
above.
