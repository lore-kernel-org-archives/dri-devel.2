Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B346DF588E2
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 14:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2249710E68B;
	Mon, 20 Apr 2026 14:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="qUklP1/p";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E7610E68B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=upUX13WxUfVDv2KYdk6gfXaZWpjy4KqeBzOXlAvSvUs=; b=qUklP1/pNbHZeVb6KXus12lq+3
 0GJmppXom6kMnXxPxwAwH9Uxv278LswdAJdgUZjVJjlljIRg0NU4CbTxVMm6smuuBSfHNbLnfWEsL
 VdyLsQgfgBQSLHe7sT+kWB29u2x/f2BnOHRv2+hfMf3+EvEk/64ifrGA6lNldakK/GM6n+OFmNYMb
 xfcvsz3Im5Nb0iTs0KrbSEXFTpQkXzX2/a/JMWryQCHH9VKqNaZCgK61TnOCwXgnfcHkaLaOsTYmy
 /zM4/ARqpEtuOka6EFu9LlocNWuAMX8A/WNnMgrC/XNUB5NeWARuBuQK92HUMeFb2MbAmtkt/sASC
 S6XLx9Mw==;
Received: from
 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl
 ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1wEpsA-00000008Zw5-1scd; Mon, 20 Apr 2026 14:45:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id C58B0301BDE; Mon, 20 Apr 2026 16:45:12 +0200 (CEST)
Date: Mon, 20 Apr 2026 16:45:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, Alessandro Carminati <acarmina@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v7 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <20260420144512.GL3102624@noisy.programming.kicks-ass.net>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-1-e8bc6e0f70de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-kunit_add_support-v7-1-e8bc6e0f70de@redhat.com>
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

On Mon, Apr 20, 2026 at 02:28:03PM +0200, Albert Esteve wrote:
> +bool __kunit_is_suppressed_warning(void)
> +{
> +	struct __suppressed_warning *warning;
> +
> +	rcu_read_lock();

	guard(rcu)();

> +	list_for_each_entry_rcu(warning, &suppressed_warnings, node) {
> +		if (warning->task == current) {
> +			warning->counter++;
> +			rcu_read_unlock();
> +			return true;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return false;
> +}
> +
> +#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
> 
> -- 
> 2.52.0
> 
