Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A61C624D3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 15:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40BD910ED54;
	Tue,  1 Sep 2026 15:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jzX7DXbx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1166010ED54
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788276594; x=1819812594; h=date:from:cc:subject:message-id;
 bh=hQLT7NYZJDMYPagK5Smpz8D9yCExQDzLK6IUT3XCwp8=;
 b=jzX7DXbx6hOSezrIntT2Bxq+T+jLjERhatp3xkznsACDbL8DPfgVZeDJ
 3dXa8T+4kLCuBbrYhOq/5V3ovYVXz8az4o5jOOrhElIWWnKquTCvqxadm
 HDuHWFP0jL/OV/Ly0/JllJHyr/USXyKYBkFWH0S28+IByU8KiUS/kpItR
 +OzRRUor4UGyqUvI8xMocNT2rmLvYZHJ8AM5cwLPcS/yz4Kewwd8BFWCT
 Wb6jms1PYRkDyr/uQoIMmyXUhyrmGk2jhCDSKsEsN49DIVSbnMR8iJ++o
 /jOSdFLboEQQXQftqDiClXEam12QbKNB9YLC+zGIfvuz2vI69TFFflJXz A==;
X-CSE-ConnectionGUID: lrEv3zbEQ32o2sY06ZtXLQ==
X-CSE-MsgGUID: fQz1F02cS4mij0b97k+7pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99871489"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="99871489"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 08:29:49 -0700
X-CSE-ConnectionGUID: EJNYPOWYTSGOf+Y0ma85FA==
X-CSE-MsgGUID: 1Y2P2GAyQ2eGM9RHK2Ed1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="262991286"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
 by fmviesa009.fm.intel.com with ESMTP; 01 Sep 2026 08:29:45 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x1QQg-0000000013E-0nJv;
 Tue, 01 Sep 2026 15:29:42 +0000
Date: Tue, 01 Sep 2026 23:29:16 +0800
From: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [drm-misc:drm-misc-next 1/4] sound/soc/ti/omap-hdmi.c:408:6:
 error: no member named 'card' in 'struct hdmi_audio_data'
Message-ID: <202609012352.GcRJ83AM-lkp@intel.com>
User-Agent: s-nail v14.9.25
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

tree:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
head:   0116f19db5931348c937eafa1f76a9a19bf82c81
commit: 1ae7fe832c2d3ecc75815eed037a07290586b6be [1/4] Merge drm/drm-next into drm-misc-next
config: powerpc-randconfig-r071-20260901 (https://download.01.org/0day-ci/archive/20260901/202609012352.GcRJ83AM-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260901/202609012352.GcRJ83AM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609012352.GcRJ83AM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> sound/soc/ti/omap-hdmi.c:408:6: error: no member named 'card' in 'struct hdmi_audio_data'
     408 |         ad->card = card;
         |         ~~  ^
   1 error generated.


vim +408 sound/soc/ti/omap-hdmi.c

50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  333  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  334  static int omap_hdmi_audio_probe(struct platform_device *pdev)
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  335  {
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  336  	struct omap_hdmi_audio_pdata *ha = pdev->dev.platform_data;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  337  	struct device *dev = &pdev->dev;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  338  	struct hdmi_audio_data *ad;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  339  	struct snd_soc_dai_driver *dai_drv;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  340  	struct snd_soc_card *card;
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  341  	struct snd_soc_dai_link_component *compnent;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  342  	int ret;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  343  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  344  	if (!ha) {
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  345  		dev_err(dev, "No platform data\n");
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  346  		return -EINVAL;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  347  	}
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  348  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  349  	ad = devm_kzalloc(dev, sizeof(*ad), GFP_KERNEL);
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  350  	if (!ad)
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  351  		return -ENOMEM;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  352  	ad->dssdev = ha->dev;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  353  	ad->ops = ha->ops;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  354  	ad->dma_data.addr = ha->audio_dma_addr;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  355  	ad->dma_data.filter_data = "audio_tx";
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  356  	ad->dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  357  	mutex_init(&ad->current_stream_lock);
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  358  
d20fa5a06d7bddb sound/soc/omap/omap-hdmi-audio.c Laurent Pinchart  2017-08-11  359  	switch (ha->version) {
d20fa5a06d7bddb sound/soc/omap/omap-hdmi-audio.c Laurent Pinchart  2017-08-11  360  	case 4:
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  361  		dai_drv = &omap4_hdmi_dai;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  362  		break;
d20fa5a06d7bddb sound/soc/omap/omap-hdmi-audio.c Laurent Pinchart  2017-08-11  363  	case 5:
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  364  		dai_drv = &omap5_hdmi_dai;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  365  		break;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  366  	default:
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  367  		return -EINVAL;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  368  	}
642a722d3116fbd sound/soc/omap/omap-hdmi-audio.c Kuninori Morimoto 2018-09-07  369  	ret = devm_snd_soc_register_component(ad->dssdev, &omap_hdmi_component,
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  370  					 dai_drv, 1);
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  371  	if (ret)
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  372  		return ret;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  373  
b1a549c6be09243 sound/soc/omap/omap-hdmi-audio.c Peter Ujfalusi    2018-05-07  374  	ret = sdma_pcm_platform_register(ad->dssdev, "audio_tx", NULL);
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  375  	if (ret)
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  376  		return ret;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  377  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  378  	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
fb5ab7296a2bea1 sound/soc/omap/omap-hdmi-audio.c Kiran Padwal      2015-02-12  379  	if (!card)
fb5ab7296a2bea1 sound/soc/omap/omap-hdmi-audio.c Kiran Padwal      2015-02-12  380  		return -ENOMEM;
fb5ab7296a2bea1 sound/soc/omap/omap-hdmi-audio.c Kiran Padwal      2015-02-12  381  
524d3f126362b60 sound/soc/ti/omap-hdmi.c         Primoz Fiser      2024-06-10  382  	card->name = "HDMI";
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  383  	card->owner = THIS_MODULE;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  384  	card->dai_link =
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  385  		devm_kzalloc(dev, sizeof(*(card->dai_link)), GFP_KERNEL);
18c94a043d6a466 sound/soc/omap/omap-hdmi-audio.c Julia Lawall      2015-12-20  386  	if (!card->dai_link)
18c94a043d6a466 sound/soc/omap/omap-hdmi-audio.c Julia Lawall      2015-12-20  387  		return -ENOMEM;
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  388  
bae071aa7bcd034 sound/soc/ti/omap-hdmi.c         Yuuki NAGAO       2025-05-31  389  	compnent = devm_kzalloc(dev, 2 * sizeof(*compnent), GFP_KERNEL);
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  390  	if (!compnent)
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  391  		return -ENOMEM;
bae071aa7bcd034 sound/soc/ti/omap-hdmi.c         Yuuki NAGAO       2025-05-31  392  	card->dai_link->cpus		= &compnent[0];
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  393  	card->dai_link->num_cpus	= 1;
1af529320d56e99 sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2023-09-11  394  	card->dai_link->codecs		= &snd_soc_dummy_dlc;
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  395  	card->dai_link->num_codecs	= 1;
bae071aa7bcd034 sound/soc/ti/omap-hdmi.c         Yuuki NAGAO       2025-05-31  396  	card->dai_link->platforms	= &compnent[1];
bae071aa7bcd034 sound/soc/ti/omap-hdmi.c         Yuuki NAGAO       2025-05-31  397  	card->dai_link->num_platforms	= 1;
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  398  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  399  	card->dai_link->name = card->name;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  400  	card->dai_link->stream_name = card->name;
3b785a63ee3d2bc sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2019-06-06  401  	card->dai_link->cpus->dai_name = dev_name(ad->dssdev);
bae071aa7bcd034 sound/soc/ti/omap-hdmi.c         Yuuki NAGAO       2025-05-31  402  	card->dai_link->platforms->name = dev_name(ad->dssdev);
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  403  	card->dai_link->init = hdmi_audio_dai_init;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  404  	card->num_links = 1;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  405  	card->dev = dev;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  406  
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  407  	atomic_set(&ad->jack_state, -1);
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19 @408  	ad->card = card;
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  409  
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  410  	snd_soc_card_set_drvdata(card, ad);
98e9645a35993f8 sound/soc/ti/omap-hdmi.c         Kuninori Morimoto 2024-01-11  411  	ret = devm_snd_soc_register_card(dev, card);
492a53506ab27d5 sound/soc/ti/omap-hdmi.c         bui duc phuc      2026-07-16  412  	if (ret)
492a53506ab27d5 sound/soc/ti/omap-hdmi.c         bui duc phuc      2026-07-16  413  		return dev_err_probe(dev, ret, "snd_soc_register_card() failed\n");
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  414  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  415  	dev_set_drvdata(dev, ad);
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  416  
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  417  	ha->audio_hpd = hdmi_audio_hpd;
699e5975e2a5382 sound/soc/ti/omap-hdmi.c         Ivaylo Dimitrov   2026-08-19  418  
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  419  	return 0;
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  420  }
50211be80290b06 sound/soc/omap/omap-hdmi-audio.c Jyri Sarha        2014-08-15  421  

:::::: The code at line 408 was first introduced by commit
:::::: 699e5975e2a53820d8248e4e69e3645d8fa3eff8 drm/omap: Report HDMI hotplug events to the ASoC HDMI codec

:::::: TO: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
:::::: CC: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
