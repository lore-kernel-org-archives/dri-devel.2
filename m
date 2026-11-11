Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC4606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=c72IFeGC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B322A10FA28;
	Wed, 11 Nov 2026 09:37:32 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BFEB10E1F9
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:28:20 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6b70880c0a4so3223137a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bairaktaris.de; s=google; t=1794385699; x=1794990499;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qa1uanI9XzLjlceRbN1zd3/NaVhLEad9qrM0rPdFptI=;
 b=c72IFeGC6j6g/cEsCPceztyjdPvGKzrS4MDz9oVFYaIkzplp4DnQg8zmkzOwmiV6ac
 yPJv1zyIMH0cmStP5/YRYQpZ7h081MeHnpbPZJuE1TfB/HJqESBkQ7WFc6ubjg9tlJFI
 MqvCZIpnPtahUdmz+Io7cy5Ycj7uYgByY1EmTtw8EDV3hWMqOy9gD7VlV3AQh6OiW6xr
 BEevzyseTmfDRsJLyU2F7O/gdGoEt7pJCwVNe/ewgqFdaw06MSjJYQTCKIBn707X5sjv
 vQ6mTKoz2z2gHEigx2bW6+U8y/1x7znhOwkCIoHZqLF4j78p+B8901Bn9nKirapDISu5
 +xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794385699; x=1794990499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qa1uanI9XzLjlceRbN1zd3/NaVhLEad9qrM0rPdFptI=;
 b=RpxrLFHXHVKRBWEbIBlMH3ZnmSaRz8tW2HwPXQTbtDlPvSLfw4sCB9pG2R3Zgjixye
 RHVazxGuf9Abzpe6/9eWwg/FGPqdKO+v+Znzf53S1tSbbVveU7KRq9rMiQBL5uuz+xrr
 X9hZ1Gnrj4HXeYNN7aNvFey2jZ3/GniB01zAAe95YBdaCyl8KK2bP4BPPlqewO68YfQm
 YVHRXviEL2roPkV0SFWWypGjzo/zJGq9WXBn+YApWiOHAOVck7eIEAoh+DPfpdeZ19OG
 psoIkgbKCzYiU/5C3Grnblc9tJlEetoJPqQ9ANZK1B5vQS6L44EJZReUR4s9nLK3NBA+
 rfBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFovxUuhtVpRjQgDLkPQ/5FulS6/jErbA/Z5TECHbUqTX+Koi0eejg6SuNtFzIvI1Vn+vEZ7sjbHQ0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+2qq1J8HsuWvTIa7agH/yRhjRyad+6FESizG3eF9U4NBiSET20
 6rw0mleoycQwkRbPvGEkzJH8Uqt9IAoqyL1I+WTVWWxSoxJhG/pt8N/j8pim6UZuCVCYhgMQzYn
 ZsUbEgFgB
X-Gm-Gg: AYBFou1LqjT5MgUb4l5YmPuEkih/HPKa7mLG17IaMZmVYZIqSWwaWUqBmY/LLKqh/fB
 NkBiEfeHDkAv7swvwqPaOwp7BehhWEdAOCiYrtGx1Uy+mwDve7jBJhi0mmYyflDJs6EvZuYezmO
 oWcScr5Qv5WfLgJq7GawH+TMH/ca7wuk0YXMNjvDOFNxNXFyLxmds7gdJlkxv8Nh/8nO7o+91Al
 OOYXuSlB+jxJQ6WkR+MwJgjwyg5AQsm7J0HuKXKquGZLJU+Re1VEnwS0NgiLE3DW5EUkfdrQQ+8
 rqp/89ky5SWd0gy0uyn6lYgyi94LEyTNWduMnsfFG651Jf8zHXy0O1xEhDsA97dAP6LZVfs/7Uf
 GeTWYrS/EYqVh3yGoKSKW/qyzEb7xvYTPRACUUM+lX6mkYDeQZguqZgrvrgbfNzCmYxEmFhbCuM
 WTeL8oMeAZQ+h5aN7azbYbHSt6MC5ioa+znEFA+wLj7tagW3jSqnpNmYsCe+4ZI274cvG3oOQwc
 xghXweA6NDBgDEv9iV/Yt0YTZQlEOC/Be+oyHpG8JIUeapnw5ij/HrPoY0slt1JjQxf1J1hiWf1
 Ewqxw6xyuVYp1ztip92Q9xECdERQvQpSW+d6YV05NmC+ioISBrk3dJFFkmtYactUQLpppagHWWK
 46GDZA0bRRqANYps5AWx4t7XIcpgVVwH4CPbHlfpi6frNG46ncbx+EucULxeut4AluUa3n6NdM5
 LibicV7EmL9WDr4ayw+vEWXQ+cA17dCI9+gCrh3Azq6I1CVdaRNT8cVqHI/U5uY20a78P6zEm+r
 FIuOjfQCoquS7ChFVxE4zJs5TgNknACYKpWTsPSuVwhojjN4h9CHSd0thys8UyO6fr4HEuBCGpv
 0ekJB2NcSaizLGCVdGI=
X-Received: by 2002:a05:6402:913:b0:6b5:5fc8:9ca2 with SMTP id
 4fb4d7f45d1cf-6b77780e04amr1206149a12.34.1794385698810; 
 Wed, 11 Nov 2026 00:28:18 -0800 (PST)
Received: from Desktop (p54aff574.dip0.t-ipconnect.de. [84.175.245.116])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b75775fcf0sm2305457a12.0.2026.11.11.00.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:28:17 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: yaoyiqi3@huawei.com
Cc: srini@kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] misc: fastrpc: Fix double free and races in
 fastrpc_req_mmap() error path
Date: Wed, 11 Nov 2026 09:28:14 +0100
Message-ID: <20261111082814.248812-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930071340.2969948-1-yaoyiqi3@huawei.com>
References: <20260930071340.2969948-1-yaoyiqi3@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 09:37:13 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 30 Sep 2026 07:13:40 +0000, Yao Yiqi wrote:
> Fix this by adding the buffer to fl->mmaps only after copy_to_user() has
> succeeded, so the buffer is not visible to a concurrent unmap while the
> response is still being copied.

The double free is still in mainline at 067c5c24cef2 and in
char-misc-next at 37a87cdaa3e2, and v3 no longer applies to either:
9e47ad9c562e ("misc: fastrpc: Allocate entire reserved memory for Audio
PD in probe") removed the remote heap block above the first hunk.

Could you rebase it onto char-misc-next and send a v4?

Reviewed-by: Julius Bairaktaris <julius@bairaktaris.de>
