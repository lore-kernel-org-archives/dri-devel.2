Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C2606A330
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E4qdlJT4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B83410E245;
	Sat, 14 Nov 2026 14:51:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5459C10E245
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794667855; x=1826203855;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xfSb5R7QVeGowcxt6acIHVsFPIN1UpvT8ACebsp3uZs=;
 b=E4qdlJT4UzjHtJQjflayjr+ildmt6kSXIpoRdU0TISCmsI1Iy/yiSO/f
 DNGIilGhwwFwy+bYXA813eQ9CtJCu+9+DklZ680+5nfEJbb7ZOz/iD0Js
 3o+S+DgaRPH71JYKIoYZP2la9khtO386NKjakOU8+IhyLidh7K73953Qo
 N/yX1l7w35VmPrsnP1mQbRJk2/2R2JcK3rbK1cdXnMD0xBc9/pDXM3GDZ
 CGbp9PoOVFL+1vbcB+owYs472jqODcYauS0QrtEqaAL7Uu032RPnqERZp
 HJwqnLAYxlbwtaG//TQpIQjDlnt44gT0AaZLjxfVS5ENUhTO3kCQPnDG2 A==;
X-CSE-ConnectionGUID: 7XUc51vdTH2KFtgZVpuSqg==
X-CSE-MsgGUID: zm5bJfnuTRSYnOM5aEpk7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3491728"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3491728"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2026 06:50:54 -0800
X-CSE-ConnectionGUID: WDUILf8cSCuARF2hXQQ1Ig==
X-CSE-MsgGUID: wIArbPdDQ7Wlmv3HV+HTsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="9160945"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa006.jf.intel.com with ESMTP; 14 Nov 2026 06:50:47 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xSF5Y-000000015cW-0yZg;
 Sat, 14 Nov 2026 14:50:44 +0000
Date: Sat, 14 Nov 2026 22:49:59 +0800
From: kernel test robot <lkp@intel.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeff Johnson <jjohnson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
 Sean Paul <sean@poorly.run>, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/9] remoteproc: qcom_wcnss: migrate to
 qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
Message-ID: <202611142207.UkqcyoQJ-lkp@intel.com>
References: <20261113185009.157893-3-mukesh.ojha@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113185009.157893-3-mukesh.ojha@oss.qualcomm.com>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mukesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on remoteproc/rproc-next]
[also build test ERROR on drm-misc/drm-misc-next ath/ath-next linus/master v7.4-rc2 next-20261113]
[cannot apply to linux-review/Mukesh-Ojha/remoteproc-qcom_wcnss-migrate-to-qcom_mdt_pas_load-and-qcom_pas_prepare_and_auth_reset/20260925-212730]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-Ojha/firmware-qcom-pas-add-qcom_pas_context_init-for-pre-allocated-context/20261114-002001
base:   https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git rproc-next
patch link:    https://lore.kernel.org/r/20261113185009.157893-3-mukesh.ojha%40oss.qualcomm.com
patch subject: [PATCH v2 2/9] remoteproc: qcom_wcnss: migrate to qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset()
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20261114/202611142207.UkqcyoQJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261114/202611142207.UkqcyoQJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611142207.UkqcyoQJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/remoteproc/qcom_wcnss.c: In function 'wcnss_load':
>> drivers/remoteproc/qcom_wcnss.c:161:75: error: passing argument 4 of 'qcom_mdt_pas_load' makes pointer from integer without a cast [-Wint-conversion]
     161 |         ret = qcom_mdt_pas_load(wcnss->pas_ctx, fw, rproc->firmware, wcnss->mem_reloc);
         |                                                                      ~~~~~^~~~~~~~~~~
         |                                                                           |
         |                                                                           phys_addr_t {aka long long unsigned int}
   drivers/remoteproc/qcom_wcnss.c:161:75: note: possible fix: take the address with '&'
     161 |         ret = qcom_mdt_pas_load(wcnss->pas_ctx, fw, rproc->firmware, wcnss->mem_reloc);
         |                                                                      ~~~~~^~~~~~~~~~~
         |                                                                      &
   In file included from drivers/remoteproc/qcom_wcnss.c:25:
   include/linux/soc/qcom/mdt_loader.h:24:58: note: expected 'phys_addr_t *' {aka 'long long unsigned int *'} but argument is of type 'phys_addr_t' {aka 'long long unsigned int'}
      24 |                       const char *firmware, phys_addr_t *reloc_base);
         |                                             ~~~~~~~~~~~~~^~~~~~~~~~


vim +/qcom_mdt_pas_load +161 drivers/remoteproc/qcom_wcnss.c

   155	
   156	static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
   157	{
   158		struct qcom_wcnss *wcnss = rproc->priv;
   159		int ret;
   160	
 > 161		ret = qcom_mdt_pas_load(wcnss->pas_ctx, fw, rproc->firmware, wcnss->mem_reloc);
   162		if (ret)
   163			return ret;
   164	
   165		qcom_pil_info_store("wcnss", wcnss->mem_phys, wcnss->mem_size);
   166	
   167		return 0;
   168	}
   169	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
