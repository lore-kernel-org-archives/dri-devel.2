Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57855606A338
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 23:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0UZpGav
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C897A10EADF;
	Sun,  1 Nov 2026 23:01:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B8B10EADF
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:01:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F8306062B;
 Sun,  1 Nov 2026 23:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731061F000C1;
 Sun,  1 Nov 2026 23:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793574090;
 bh=0UiNF2mRSaBX03RL18h3QU/ZLYC6k7KWXPLfr5uKQu4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=a0UZpGavCMbxV+NQxzhWQsTFySbnG8gry1G//WQT0WydeYudWgbOp03/WnWxVVZRb
 OTZ5O/bObqbOQ2lnvDuqTrbMKrQDSG2mMu8Ic2RZ/QDEWKdcoh7H8BEDWINCPo2y6G
 04XXsIRKc5Jce3MPgVCOE4WUHAqwtOA3i67XPp/9/b7vHBI9EssL6xraFBBBZqCIOt
 eRizDTPiCH4KElKTyaF9T+XBHHLk2SwwZm4NswkCF2Tzr3pAC/qmsV9DeqgkKYTxpK
 PXxGFAsocL6dnXmpZT1ajaFrBNQJ9Fc6BbV5uRRLZF33hUnZHalD2u4mOsNc/JtfyZ
 3iZmqZmkwtRiw==
Subject: Re: [PATCH net v5 4/4] selftests: net: add devmem RX and TX netdev
 unregister tests
From: netdev-bot+sashiko@kernel.org
To: almasrymina@google.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, pabeni@redhat.com, sdf@fomichev.me,
 kaiyuanz@google.com, kuba@kernel.org, bobbyeshleman@meta.com,
 asml.silence@gmail.com, dw@davidwei.uk, ap420073@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
 sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org,
 tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
Date: Sun, 01 Nov 2026 23:01:27 +0000
Message-ID: <179357408797.3131.706180156061595645@kernel.org>
In-Reply-To: <20261030083539.777877-5-almasrymina@google.com>
References: <20261030083539.777877-5-almasrymina@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch adds CONFIG_UDMABUF=y to
  tools/testing/selftests/net/config, but the fragment does not pull in…

--

selftests: net: add devmem RX and TX netdev unregister tests

This adds devmem_bind_rx_unregister_check and
devmem_bind_tx_unregister_check to nl_netdev.py. They check that removing a
netdevsim device while a netlink socket holds an RX or TX devmem binding
detaches the dma_buf right away. The commit also adds the dma-buf, udmabuf
and devmem options the tests need to the net selftest config fragment.

> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index d4416f8bdcfd1..7a89e2618d4c4 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config

[ ... ]

> @@ -133,6 +136,7 @@ CONFIG_TEST_BLACKHOLE_DEV=m
>  CONFIG_TLS=m
>  CONFIG_TRACEPOINTS=y
>  CONFIG_TUN=y
> +CONFIG_UDMABUF=y

[Severity: Low]
Will CONFIG_UDMABUF=y actually get enabled from this fragment on a minimal
base config? UDMABUF in drivers/dma-buf/Kconfig has these dependencies:

config UDMABUF
	bool "userspace dmabuf misc driver"
	default n
	depends on DMA_SHARED_BUFFER
	depends on MEMFD_CREATE || COMPILE_TEST
	depends on MMU

CONFIG_SYNC_FILE=y takes care of DMA_SHARED_BUFFER. MEMFD_CREATE has no
default, though, and can only be set directly under EXPERT. Normally it
is turned on because TMPFS or HUGETLBFS selects it, and this fragment
asks for neither.

If the base config has MEMFD_CREATE=n and COMPILE_TEST=n, Kconfig will
quietly drop UDMABUF. Both new tests would then skip in _create_udmabuf()
and never reach the unregister path:

    if not os.path.exists("/dev/udmabuf"):
        raise KsftSkipEx("/dev/udmabuf is not available")

tools/testing/selftests/bpf/config lists CONFIG_TMPFS=y next to
CONFIG_UDMABUF=y, and tools/testing/selftests/drivers/net/hw/config has
CONFIG_HUGETLBFS=y. Should CONFIG_TMPFS=y be added here as well?

>  CONFIG_USER_NS=y
>  CONFIG_VETH=y
>  CONFIG_VLAN_8021Q=y

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030083539.777877-1-almasrymina%40google.com
